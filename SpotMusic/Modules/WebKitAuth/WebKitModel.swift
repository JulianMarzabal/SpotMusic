//
//  WebKitModel.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 21/03/2023.
//

import Foundation

struct OauthTokenResponse: Codable {
    let access_token: String
    let token_type: String
    let scope: String
    let expires_in: Int
    let refresh_token: String
    
      
    
}
