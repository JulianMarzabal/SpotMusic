//
//  RecommendationsModel.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 26/03/2023.
//

import Foundation

struct TrackResponse: Codable {
    let tracks: [TrackRecommendation]
}


struct TrackRecommendation: Codable {
    let artists: [Artist]?
    let discNumber: Int?
    let durationMs: Int?
    let explicit: Bool?
 
    let href: String?
    let id: String
    let isPlayable: Bool?
  
    let name: String
    let popularity: Int
    let previewUrl: String?
   
    let uri: String
  
}

struct AlbumRecommendation: Codable {
   
    let href: String
    let id: String
    let images: [ImageRecommendation]
    let name: String
    let releaseDate: String
    let releaseDatePrecision: String
    
    let type: String
    let uri: String

    let genres: [String]
    let label: String
    let popularity: Int
    let albumGroup: String?
    let artists: [Artist]
}

struct ArtistRecommendation: Codable {

    let genres: [String]
    let href: String
    let id: String
    let images: [ImageRecommendation]
    let name: String
    let popularity: Int
    let type: String
    let uri: String
}



struct ImageRecommendation: Codable {
    let url: String
    let height: Int
    let width: Int
}





