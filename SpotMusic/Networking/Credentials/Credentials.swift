//
//  Credentials.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 30/03/2023.
//

import Foundation

struct SpotMusicCredentials {
    static let  userID = "21i2rjgjdpnbf74apyug7a2ta"
    static let clientID: String = ProcessInfo.processInfo.environment["client_ID"] ?? "Default"
    static let clientSecretID: String = ProcessInfo.processInfo.environment["client_SecretID"] ?? "Default"
    private static func base64EncodedCredentials() -> String {
            let credentialsString = "\(clientID):\(clientSecretID)"
            guard let credentialsData = credentialsString.data(using: .utf8) else {
                return "Default"
            }
            return credentialsData.base64EncodedString()
        }
        
        static let authorization: String = {
            let base64Credentials = base64EncodedCredentials()
            return "Basic \(base64Credentials)"
        }()
}
