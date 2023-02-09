//
//  KeychainManager.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 22/01/2023.
//

import Foundation
import Security

class KeychainManager {
  
    enum KeychainError: Error {
        case duplicateEntry
        case noPassword
        case unknown(OSStatus)
    }
    
    static func save(token: Data, account: String) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: token as AnyObject
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess {
            try updateToken(token: token, account: account)
        } else {
            let status = SecItemAdd(query as CFDictionary, nil)
            
            guard status == errSecSuccess else {
                throw KeychainError.unknown(status)
            } 
        }
        print("saved")
    }
    
    static func readToken(account: String) -> Data? {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: true as AnyObject
        ]
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        return result as? Data
        
    }
   




    
    static func updateToken(token:Data,account: String) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
        ]
       
        let updatedData = [kSecValueData:token] as CFDictionary
        
        let status = SecItemUpdate(query as  CFDictionary ,updatedData)
        guard status != errSecItemNotFound else {
            throw KeychainError.noPassword
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
        
    }
  
    
}

