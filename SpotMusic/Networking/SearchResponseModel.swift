//
//  SearchResponseModel.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 26/02/2023.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let searchItem = try? JSONDecoder().decode(SearchItem.self, from: jsonData)



// MARK: - SearchItem
struct SearchItem: Codable {
    let tracks: Tracks
    let artists: Artists?
    let albums: Albums?
    let playlists: Playlists?
 
}

// MARK: - Albums
struct Albums: Codable {
    let href: String
    let limit: Int
    let next: String
    let offset: Int
    let previous: String
    let total: Int
    let items: [AlbumElement]
}

// MARK: - AlbumElement
struct AlbumElement: Codable {
    let albumType: String
    let totalTracks: Int
    let availableMarkets: [String]
    let externalUrls: ExternalUrls
    let href, id: String
    let images: [SearchImage]
    let name, releaseDate, releaseDatePrecision: String
    let restrictions: Restrictions?
    let type, uri: String
    let copyrights: [Copyright]?
    let externalIDS: ExternalIDS?
    let genres: [String]?
    let label: String?
    let popularity: Int?
    let albumGroup: String?
    let artists: [Artist]

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case totalTracks = "total_tracks"
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case restrictions, type, uri, copyrights
        case externalIDS = "external_ids"
        case genres, label, popularity
        case albumGroup = "album_group"
        case artists
    }
}

// MARK: - Artist
struct Artist: Codable {
    let externalUrls: ExternalUrls?
    let href, id, name, type: String
    let uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, name, type, uri
    }
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String
}

// MARK: - Copyright
struct Copyright: Codable {
    let text, type: String?
}

// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    let isrc, ean, upc: String?
}

// MARK: - Image
struct SearchImage: Codable {
    let url: String
    let height, width: Int
}

// MARK: - Restrictions
struct Restrictions: Codable {
    let reason: String?
}

// MARK: - Artists
struct Artists: Codable {
    let href: String
    let limit: Int
    let next: String
    let offset: Int
    let previous: String
    let total: Int
    let items: [ArtistElement]
}

// MARK: - ArtistElement
struct ArtistElement: Codable {
    let externalUrls: ExternalUrls
    let followers: Followers?
    let genres: [String]?
    let href, id: String
    let images: [SearchImage]?
    let name: String
    let popularity: Int?
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, genres, href, id, images, name, popularity, type, uri
    }
}

// MARK: - Followers
struct Followers: Codable {
    let href: String?
    let total: Int?
}







// MARK: - Playlists
struct Playlists: Codable {
    let href: String
    let limit: Int
    let next: String
    let offset: Int
    let previous: String
    let total: Int
    let items: [PlaylistsItem]
}

// MARK: - PlaylistsItem
struct PlaylistsItem: Codable {
    let collaborative: Bool
    let description: String
    let externalUrls: ExternalUrls
    let href, id: String
    let images: [SearchImage]
    let name: String
    let owner: Owner
    let itemPublic: Bool
    let snapshotID: String
    let tracks: Followers
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case collaborative, description
        case externalUrls = "external_urls"
        case href, id, images, name, owner
        case itemPublic = "public"
        case snapshotID = "snapshot_id"
        case tracks, type, uri
    }
}

// MARK: - Owner
struct Owner: Codable {
    let externalUrls: ExternalUrls
    let followers: Followers
    let href, id, type, uri: String
    let displayName: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, href, id, type, uri
        case displayName = "display_name"
    }
}

// MARK: - Tracks
struct Tracks: Codable {
    let href: String
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
    let items: [TracksItem]
}

// MARK: - TracksItem
struct TracksItem: Codable {
    let album: AlbumElement
    let artists: [ArtistElement]
    let availableMarkets: [String]
    let discNumber, durationMS: Int
    let explicit: Bool
    let externalIDS: ExternalIDS
    let externalUrls: ExternalUrls
    let href, id: String
    let isPlayable: Bool?
    let linkedFrom: LinkedFrom?
    let restrictions: Restrictions?
    let name: String
    let popularity: Int
    let previewURL: String
    let trackNumber: Int
    let type, uri: String
    let isLocal: Bool

    enum CodingKeys: String, CodingKey {
        case album, artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href, id
        case isPlayable = "is_playable"
        case linkedFrom = "linked_from"
        case restrictions, name, popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
        case isLocal = "is_local"
    }
}

// MARK: - LinkedFrom
struct LinkedFrom: Codable {
}
