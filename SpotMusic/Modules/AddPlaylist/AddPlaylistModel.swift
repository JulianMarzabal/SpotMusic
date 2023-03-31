//
//  AddPlaylistModel.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 24/03/2023.
//

import Foundation


struct CreatePlaylistResponse: Decodable {
    let href:String
    let id:String
    let images: [ImageCreatePlaylist]
    let name:String
    let tracks: TracksCreatePlaylist
    
    
    
    
    
}

struct ImageCreatePlaylist: Decodable {
    let url:String
    let height: Int
    let width:Int
}
struct TracksCreatePlaylist: Decodable {
    let href: String
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
}
