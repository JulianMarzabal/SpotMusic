//
//  TrackRecommendationsModel.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 31/03/2023.
//

import Foundation


struct TrackRecommendationsModel {
    let id: String
    let isPlayable: Bool?
    let name: String
    let popularity: Int
    let previewUrl: String?
    let uri: String
    let image:String
}
