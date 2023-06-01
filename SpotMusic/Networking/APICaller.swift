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
    case badSerialization
    
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
    case addItemsToPlaylist(playlistID:String, uri:String)

    var uri: String {
        switch self {
        case .authorization:
            return "/authorize"
        case .login, .loginOAuth:
            return "/api/token"
        case let .userPlaylist(userID):
            return "/v1/users/\(userID)/playlists?limit=50&offset=0"
        case let .playlistDetail(playlistID):
            return "/v1/playlists/\(playlistID)/tracks"
        case let .searchItem(search):
            return  "/v1/search?q=\(search)&type=track"
        case let .createPlaylist(userID, _):
            return "/v1/users/\(userID)/playlists"
        case  .getRecommendations:
            return "/v1/recommendations"
        case let .addItemsToPlaylist(playlistID,_):
            return "/v1/playlists/\(playlistID)/tracks"
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
        case .login, .createPlaylist, .addItemsToPlaylist:
            return false
        default:
            return true
        }
    }
    
    var requiresOAuthAuthentication:Bool {
        switch self {
        case .addItemsToPlaylist:
            return true
        default:
            return false
        }
    }
    
    var method: String {
        switch self {
        case .login,.createPlaylist,.loginOAuth, .addItemsToPlaylist:
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
    func addItemToPlaylist(playlistID:String, uri:String, completion:@escaping (Result<AddItemResponse,Error>) ->Void)
   
}



class API:APIProtocol {
    
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
        if settings.requiresOAuthAuthentication {
            let OAuthToken = getOauthToken()
            request.setValue("Bearer \(OAuthToken)", forHTTPHeaderField: "Authorization")
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
                print("Status code: \(response.statusCode)")
                   print("Response data: \(String(data: data, encoding: .utf8) ?? "No data")")
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
            URLQueryItem(name: "scope", value: "playlist-modify-public playlist-modify-private"),
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
        makeBasicRequest(settings: .login(authorization:SpotMusicCredentials.authorization ), bodyData: "grant_type=client_credentials".data(using: .utf8), parameters: nil, onSuccess: {response in
            completion(.success(response))
        }, onError: {error  in
            print("Error in getAccessToken: \(error)")
            completion(.failure(error))})
        
        
    }
        
    
    func getUserPlaylist(completion: @escaping (Result<UserPlaylistResponse,Error>) -> Void) {
        print(SpotMusicCredentials.clientID)
        makeBasicRequest(settings: .userPlaylist(
            userID:  "21i2rjgjdpnbf74apyug7a2ta"),
                         bodyData:nil, parameters: nil,
                         onSuccess: {response in completion(.success(response))},
                         onError: {error in
            print("Error in getUserPlaylist: \(error)")
            completion(.failure(error))}
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
    
    func addItemToPlaylist(playlistID:String, uri:String, completion:@escaping (Result<AddItemResponse,Error>) ->Void) {
        let parameters:[String:Any] = [
            "uris": [uri],
            "position": 0,
        ]
        do {
            let bodyData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            makeBasicRequest(settings: .addItemsToPlaylist(playlistID: playlistID, uri: uri), bodyData: bodyData, parameters: nil, onSuccess: {response in completion(.success(response))}, onError: {error in completion(.failure(error))})
        }
        catch {
            completion(.failure(SpotiError.badSerialization))
            
        }
        
        
        //makeBasicRequest(settings: .addItemsToPlaylist(playlistID: playlistID, uri: uri), bodyData:bodyd , parameters: nil, onSuccess: {response in completion(.success(response))}, onError: {error in completion(.failure(error))})
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








