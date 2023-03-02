//
//  APICaller.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 22/01/2023.
//https://api.spotify.com/v1/search?q=asitwas&type=track

import Foundation

enum SpotiError:Error {
    case notFound
    case badResponse
    
}

enum RequestSettings {
    case login(authorization:String)
    case userPlaylist(userID:String)
    case playlistDetail(playlistID:String)
    case searchItem(search:String)

    var uri: String {
        switch self {
        case .login:
            return "/api/token"
        case let .userPlaylist(userID):
            return "/v1/users/\(userID)/playlists"
        case let .playlistDetail(playlistID):
            return "/playlists/\(playlistID)/tracks"
        case let .searchItem(search):
            return  "/v1/search?q=\(search)&type=track"
        
        }
    }
    var baseURL:String {
        switch self {
        case .login:
            return "https://accounts.spotify.com"
        default:
            return "https://api.spotify.com"
        }
    
    }
    
    var requiresAuthentication:Bool {
        switch self {
        case .login:
            return false
        default:
            return true
        }
    }
    
    var method: String {
        switch self {
        case .login:
            return "POST"
        case .playlistDetail,.userPlaylist,.searchItem:
            return "GET"
        }
    }
    var contentType: String {
        switch self {
        case .login:
            return "application/x-www-form-urlencoded"
        default:
            return "application/json"
            
        }
    }
    var autenticationType:String {
        switch self {
        case .login(let value):
            return value
        default:
            return ""
        }
    }
    
}


protocol APIProtocol {
    func getAccessToken(completion: @escaping (Result<AuthenticationResponse,Error>) -> Void)
    func getUserPlaylist(completion: @escaping (Result<UserPlaylistResponse,Error>) -> Void)
    func getPlaylistDetails(playlistID:String, completion: @escaping (Result<PlaylistTrack,Error>) -> Void)
    func searchItem(nameItem:String, completion: @escaping (Result<SearchItem,Error>) ->Void)
   
}



class API:APIProtocol {
    var authenticationManager = AuthManager()
    static let shared = API()
    
    private func makeBasicRequest<T:Decodable>(settings:RequestSettings,bodyData:Data?, onSuccess: @escaping (T) -> Void, onError: @escaping (Error) -> Void){
        guard let url = URL(string: "\(settings.baseURL)\(settings.uri)")   else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = settings.method
        request.setValue(settings.contentType, forHTTPHeaderField: "Content-Type")
        if let bodyData = bodyData {
            request.httpBody = bodyData
        }
        if settings.requiresAuthentication {
            let token = getUserToken()
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
       
        if !settings.autenticationType.isEmpty{
            request.setValue(settings.autenticationType, forHTTPHeaderField: "Authorization")
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
                    self?.makeBasicRequest(settings: settings, bodyData: bodyData, onSuccess: onSuccess, onError: onError)
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
    
    func getAccessToken(completion: @escaping (Result<AuthenticationResponse,Error>) -> Void) {
        makeBasicRequest(settings: .login(authorization: "Basic MTk3MDU0MTFmMmJkNDU4M2EyNTM4NjQxZWY3YzQ4NTY6NDY5NWJmMmMwYTU1NDVjZjljNGU3ODE4OGNmNDRhM2Q="), bodyData: "grant_type=client_credentials".data(using: .utf8), onSuccess: {response in
            completion(.success(response))
        }, onError: {error  in completion(.failure(error))})
        
        
    }
        
    
    func getUserPlaylist(completion: @escaping (Result<UserPlaylistResponse,Error>) -> Void) {
        makeBasicRequest(settings: .userPlaylist(
                        userID:  "21i2rjgjdpnbf74apyug7a2ta"),
                         bodyData:nil,
                         onSuccess: {response in completion(.success(response))},
                         onError: {error in completion(.failure(error))}
                         )
        
    }
    
    func getPlaylistDetails(playlistID:String, completion: @escaping (Result<PlaylistTrack,Error>) -> Void){
        
        
        
        //makeBasicRequest(settings: .playlistDetail(playlistID: playlistID), bodyData: nil, onSuccess: {response in completion(.success(response))}, onError: {error in completion(.failure(error))})
    
        //let userToken = getUserToken()
   
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
                         bodyData: nil,
                         onSuccess: {response in completion(.success(response))}, onError: {error in completion(.failure(error))})
      
        
    }
    
    
    
    
    // Get String User token to fetch
    func getUserToken() -> String {
        let userToken = KeychainManager.readToken(account: "Usertoken")
           guard let token = userToken else { return "Unkown" }
           return String(decoding: token, as: UTF8.self)
    }
    
    

    
    
}








