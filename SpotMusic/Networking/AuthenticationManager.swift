//
//  AuthenticationManager.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 02/02/2023.
//

import Foundation

class AuthManager {
    
    func renewToken(completion: @escaping () -> Void){
        API.shared.getAccessToken(completion: {result in
            switch result{
                
            case .success(let authenticationResponse):
                do {
                    let acessToken = authenticationResponse.access_token.data(using: .utf8)!
                    try KeychainManager.save(token: acessToken, account: "Usertoken")
                    completion()
                }catch{
                    
                }
            case .failure:
                completion()
            }
            
        })
        
    }
    
    
    
    
}
