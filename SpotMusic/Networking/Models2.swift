//
//  Models2.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 02/02/2023.
//


import Foundation

// MARK: - PlaylistTrack
struct PlaylistTrack: Decodable {
    
    
    let href: String
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
    
    let itemsList: [Item]
    
    enum CodingKeys:String, CodingKey {
        case href
        case limit
        case next
        case offset
        case previous
        case total
        case itemsList = "items"
        
        
        
    }
}


// MARK: - Item
struct Item:Decodable {
    let addedAt: Date?
    let isLocal: Bool?
    let track: Track
}


// MARK: - Track
struct Track: Decodable {
    let album: Album
    let available_markets: [String]
    let disc_number, duration_ms: Int
    let explicit: Bool


    let href, id: String
    let name: String
    let popularity: Int
    let preview_url: String?
    let track_number: Int
    let type, uri: String
    let is_local: Bool
    
    
}

// MARK: - Album
struct Album:Decodable {

    let total_tracks: Int
    let available_markets: [String]
    let href, id: String
    let images: [Image]
    let name, release_date, release_date_precision: String
    let type, uri: String

    let label: String?
 

}




// MARK: - Image
struct Image:Decodable {
    let url: String
    let height, width: Int
}








        

