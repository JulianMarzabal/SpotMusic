//
//  APICaller.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 22/01/2023.


import Foundation
import WebKit

var webView: WKWebView!

enum SpotiError:Error {
    case notFound
    case badResponse
    case badURL
    
}



enum RequestSettings {
    case authorization
    case login(authorization:String)
    case loginOAuth(basicAuthorization:String)
    case userPlaylist(userID:String)
    case playlistDetail(playlistID:String)
    case searchItem(search:String)
    case createPlaylist(userID:String, authorization:String)
    case getRecommendations(authorization:String)

    var uri: String {
        switch self {
        case .authorization:
            return "/authorize"
        case .login, .loginOAuth:
            return "/api/token"
        case let .userPlaylist(userID):
            return "/v1/users/\(userID)/playlists?limit=50&offset=0"
        case let .playlistDetail(playlistID):
            return "/playlists/\(playlistID)/tracks"
        case let .searchItem(search):
            return  "/v1/search?q=\(search)&type=track"
        case let .createPlaylist(userID, _):
            return "/v1/users/\(userID)/playlists"
        case  .getRecommendations:
            return "/v1/recommendations"
        
        }
    }
    var baseURL:String {
        switch self {
        case .login, .authorization, .loginOAuth:
            return "https://accounts.spotify.com"
        default:
            return "https://api.spotify.com"
        }
    
    }
    
    var requiresBasicAuthentication:Bool {
        switch self {
        case .login, .createPlaylist:
            return false
        default:
            return true
        }
    }
    
    var method: String {
        switch self {
        case .login,.createPlaylist,.loginOAuth:
            return "POST"
        case .playlistDetail,.userPlaylist,.searchItem,.authorization, .getRecommendations:
            return "GET"
        }
    }
    var contentType: String {
        switch self {
        case .login,.loginOAuth:
            return "application/x-www-form-urlencoded"
        default:
            return "application/json"
            
        }
    }
    var autenticationType:String {
        switch self {
        case .login(let value):
            return value
        case .loginOAuth(let value):
            return value
        case .createPlaylist(_,let authorization):
            return authorization
        case .getRecommendations(let authorization):
            return authorization
        default:
            return ""
        }
    }
    
}


protocol APIProtocol {
    func getAccessToken(completion: @escaping (Result<AuthenticationResponse,Error>) -> Void)
    func getAccesTokenOauth(code:String, completion: @escaping (Result<OauthTokenResponse,Error>) -> Void)
    func getUserPlaylist(completion: @escaping (Result<UserPlaylistResponse,Error>) -> Void)
    func getPlaylistDetails(playlistID:String, completion: @escaping (Result<PlaylistTrack,Error>) -> Void)
    func searchItem(nameItem:String, completion: @escaping (Result<SearchItem,Error>) ->Void)
    func getAuthorization() -> URLRequest?
    func createPlaylist(name:String, completion: @escaping (Result<CreatePlaylistResponse,Error>) -> Void)
    func getRecommendations(completion: @escaping (Result<TrackResponse,Error>) ->Void)
   
}



class API:APIProtocol {
    
    static var userID: String = "21i2rjgjdpnbf74apyug7a2ta"
    

    
   
    
    
    var authenticationManager = AuthManager()
    static let shared = API()
    
    private func makeBasicRequest<T:Decodable>(settings:RequestSettings,bodyData:Data?,parameters: [String: Any]?, onSuccess: @escaping (T) -> Void, onError: @escaping (Error) -> Void){
        guard let url = URL(string: "\(settings.baseURL)\(settings.uri)")   else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = settings.method
        request.setValue(settings.contentType, forHTTPHeaderField: "Content-Type")
        if let bodyData = bodyData {
    
            request.httpBody = bodyData
        }
        
        if settings.requiresBasicAuthentication {
            let token = getUserToken()
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
       
        if !settings.autenticationType.isEmpty{
            request.setValue(settings.autenticationType, forHTTPHeaderField: "Authorization")
        }
        if let parameters = parameters {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: String(describing: value))
            }
            guard let finalURL = urlComponents?.url else {
                onError(SpotiError.badURL)
                return
            }
            request.url = finalURL
        }
        
        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            guard let data = data, error == nil, let response = response as?  HTTPURLResponse else {
                return
            }
            switch response.statusCode {
            case 200,201:
                break
           case 401:
               authenticationManager.renewToken {[weak self] in
                    self?.makeBasicRequest(settings: settings, bodyData: bodyData, parameters: parameters, onSuccess: onSuccess, onError: onError)
                }
                return
            default:
                onError(SpotiError.badResponse)
                return
            }
            
            
           
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
               onSuccess(response)
                
            } catch {
                onError(SpotiError.badResponse)
                print(error)
            }
        
        }
        task.resume()
        
        
    }
    func getAuthorization() -> URLRequest? {
        var components = URLComponents(string: "https://accounts.spotify.com/authorize")
        components?.queryItems = [
            URLQueryItem(name: "client_id", value: "19705411f2bd4583a2538641ef7c4856"),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: "playlist-modify-public"),
            URLQueryItem(name: "redirect_uri", value: "https://5acc-190-173-105-153.sa.ngrok.io/callback/")
        ]
        guard let url = components?.url else { return nil }
        let request = URLRequest(url: url)
        return request
        
       
    }
    
    func getAccesTokenOauth(code:String ,completion: @escaping (Result<OauthTokenResponse,Error>) -> Void) {
        let uri = "https://5acc-190-173-105-153.sa.ngrok.io/callback/"
        makeBasicRequest(settings: .loginOAuth(basicAuthorization:"Basic MTk3MDU0MTFmMmJkNDU4M2EyNTM4NjQxZWY3YzQ4NTY6NDY5NWJmMmMwYTU1NDVjZjljNGU3ODE4OGNmNDRhM2Q="), bodyData: "grant_type=authorization_code&code=\(code)&redirect_uri=\(uri)".data(using: .utf8), parameters: nil, onSuccess: {response in completion(.success(response))}, onError: {error in completion(.failure(error))})
        
        
        
        
    }
    
    func getAccessToken(completion: @escaping (Result<AuthenticationResponse,Error>) -> Void) {
        makeBasicRequest(settings: .login(authorization: "Basic MTk3MDU0MTFmMmJkNDU4M2EyNTM4NjQxZWY3YzQ4NTY6NDY5NWJmMmMwYTU1NDVjZjljNGU3ODE4OGNmNDRhM2Q="), bodyData: "grant_type=client_credentials".data(using: .utf8), parameters: nil, onSuccess: {response in
            completion(.success(response))
        }, onError: {error  in completion(.failure(error))})
        
        
    }
        
    
    func getUserPlaylist(completion: @escaping (Result<UserPlaylistResponse,Error>) -> Void) {
        print(API.userID)
        makeBasicRequest(settings: .userPlaylist(
            userID:  API.userID),
                         bodyData:nil, parameters: nil,
                         onSuccess: {response in completion(.success(response))},
                         onError: {error in completion(.failure(error))}
                         )
        
    }
    
    func getPlaylistDetails(playlistID:String, completion: @escaping (Result<PlaylistTrack,Error>) -> Void){
        
        
   
        guard let url = URL(string: "https://api.spotify.com/v1/playlists/\(playlistID)/tracks")  else {return}
        var request = URLRequest(url: url)
        let token = getUserToken()
        print(token)
       
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
       
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {return}
            do {
                let response = try JSONDecoder().decode(PlaylistTrack.self, from: data)
                completion(.success(response))
                
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
       
        
    }
    
    func searchItem(nameItem:String, completion: @escaping (Result<SearchItem,Error>) ->Void) {
        makeBasicRequest(settings: .searchItem(search: nameItem),
                         bodyData: nil, parameters: nil,
                         onSuccess: {response in completion(.success(response))},
                         onError: {error in completion(.failure(error))})
      
        
    }
    
    func createPlaylist(name:String, completion: @escaping (Result<CreatePlaylistResponse,Error>) -> Void) {
        let userID = "21i2rjgjdpnbf74apyug7a2ta"
        let json:[String:Any] = [
            "name": "\(name)",
            "description": "",
            "public": true
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        let OAuthToken = getOauthToken()
        
        
    
        makeBasicRequest(settings: .createPlaylist(userID: userID, authorization: "Bearer \(OAuthToken)"),
                         bodyData: jsonData, parameters: nil,
                         onSuccess: {response in completion(.success(response))},
                         onError: {error in completion(.failure(error))})
        
        
    }
    func getRecommendations(completion: @escaping (Result<TrackResponse,Error>) ->Void){
//        let OAuthToken = "BQB5GOOYeCXGctV02VMq8x6irnJf3NrlQRRlGWw1Nh4VLe_-UNFJKsQFODNQidhEq6ke_Zkfxl-jAPBZNFp-PQbjtg_zc-AbIc1UEr-oGbjQE5H5Qqd2KCcOEFPYnj7Me9d-XpfB7W8YQDRWv3HR6e847qwl8ZCq1Agvj_TicJkdxP6bF8s1omdaALPTwslk7rGuaacJQ30mywJO-mo2Js4N88ld5sCU7IcMyQY"
        let OAuthToken = getOauthToken()
        let parametres:[String:Any] = [
            "seed_artist": "6KImCVD70vtIoJWnq6nGn3",
            "seed_genres": "latino,pop,reggaeton",
            "seed_tracks": "4W4fNrZYkobj539TOWsLO2"
        ]
        
        makeBasicRequest(settings: .getRecommendations(authorization: "Bearer \(OAuthToken)"),
                         bodyData: nil, parameters: parametres, onSuccess: {response in completion(.success(response))},
                         onError: {error in completion(.failure(error))})
        
    }
    
    
    
    
    // Get String User token to fetch
    func getUserToken() -> String {
        let userToken = KeychainManager.readToken(account: "Usertoken")
           guard let token = userToken else { return "Unkown" }
           return String(decoding: token, as: UTF8.self)
    }
    
    func getOauthToken() -> String {
        let tokenOAuth = KeychainManager.readToken(account: "tokenOAuth")
        guard let tokenOAuth = tokenOAuth else {return "Unkown"}
        return String(decoding: tokenOAuth, as: UTF8.self)
    }
    
    

    
    
}








