//
//  WebKitAuthViewModel.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 19/03/2023.
//

import Foundation
class ServiceManager {
    static var shared = ServiceManager()
    var isOAuth2 = false
}

class WebKitAuthViewModel {
    var api:APIProtocol = API.shared
    
   
    
    
    func getAuthorizationToken() -> URLRequest? {
        return api.getAuthorization()
    
    }
    
    func getAcessToken(code:String) {
        api.getAccesTokenOauth(code: code, completion: {[weak self] result in
            switch result {
            case .success(let oauthToken):
                do {
                    let tokenOauth = oauthToken.access_token.data(using: .utf8)!
                    let readOAUTH = oauthToken.access_token
                    print(readOAUTH)
                    try KeychainManager.save(token: tokenOauth, account: "tokenOAuth")
                    ServiceManager.shared.isOAuth2 = true
                    print("token oauth guardado")
                  
                    
                    
                    
                    
                }catch {
                    
                }
                
            
            case .failure(_):
                print(SpotiError.badResponse)
            }
        
        })
    }
    
    
    
}
