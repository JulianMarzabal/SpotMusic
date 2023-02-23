//
//  Models.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 29/01/2023.
//

import Foundation
//POST Model
struct AuthenticationResponse: Codable {
    let access_token:String
    let expires_in:Int
    let token_type:String?
    
}


//GET Userplaylist Model

struct UserPlaylistResponse: Codable{
    let items: [UserPlaylist]
}

struct UserPlaylist: Codable {
    let collaborative: Bool
        let description: String
        let externalUrls: String?
        let href: String
        let id: String
        let images: [UserPlaylistImage]?
        let name: String
        let userPlaylistPublic: Bool?
        let snapshotID: String?
        //let tracks: String?
        let type, uri: String?
}
 

struct UserPlaylistImage: Codable {
    let height: Int?
    let url : String?
    let width: Int?
   
}


// GET Playlist by ID


