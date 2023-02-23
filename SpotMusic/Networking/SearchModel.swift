//
//  SearchModel.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 21/02/2023.
//


import Foundation

// MARK: - SearchItem
struct SearchItem: Codable {
    let tracks: Tracks
    let artists: Artists
    let albums: Albums
    let playlists: Playlists
    let shows: Audiobooks
    let episodes: Episodes
    let audiobooks: Audiobooks
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
    let href: Href
    let id: String
    let images: [SearchImage]
    let name: Href
    let releaseDate, releaseDatePrecision: String
    let restrictions: Restrictions
    let type, uri: String
    let copyrights: [Copyright]
    let externalIDS: ExternalIDS
    let genres: [String]
    let label: Href
    let popularity: Int
    let albumGroup: String
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
    let externalUrls: ExternalUrls
    let href, id, name: Href
    let type: String
    let uri: Href

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, name, type, uri
    }
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: Href
}

enum Href: String, Codable {
    case string = "string"
}

// MARK: - Copyright
struct Copyright: Codable {
    let text, type: Href
}

// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    let isrc, ean, upc: Href
}

// MARK: - Image
struct SearchImage: Codable {
    let url: String
    let height, width: Int
}

// MARK: - Restrictions
struct Restrictions: Codable {
    let reason: String
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
    let followers: Followers
    let genres: [String]
    let href, id: Href
    let images: [SearchImage]
    let name: Href
    let popularity: Int
    let type: String
    let uri: Href

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, genres, href, id, images, name, popularity, type, uri
    }
}

// MARK: - Followers
struct Followers: Codable {
    let href: Href
    let total: Int
}

// MARK: - Audiobooks
struct Audiobooks: Codable {
    let href: String
    let limit: Int
    let next: String
    let offset: Int
    let previous: String
    let total: Int
    let items: [AudiobooksItem]
}

// MARK: - AudiobooksItem
struct AudiobooksItem: Codable {
    let authors: [Author]?
    let availableMarkets: [Href]
    let copyrights: [Copyright]
    let description, htmlDescription: Href
    let edition: String?
    let explicit: Bool
    let externalUrls: ExternalUrls
    let href, id: Href
    let images: [SearchImage]
    let languages: [Href]
    let mediaType, name: Href
    let narrators: [Author]?
    let publisher: Href
    let type: String
    let uri: Href
    let totalChapters: Int?
    let isExternallyHosted: Bool?
    let totalEpisodes: Int?

    enum CodingKeys: String, CodingKey {
        case authors
        case availableMarkets = "available_markets"
        case copyrights, description
        case htmlDescription = "html_description"
        case edition, explicit
        case externalUrls = "external_urls"
        case href, id, images, languages
        case mediaType = "media_type"
        case name, narrators, publisher, type, uri
        case totalChapters = "total_chapters"
        case isExternallyHosted = "is_externally_hosted"
        case totalEpisodes = "total_episodes"
    }
}

// MARK: - Author
struct Author: Codable {
    let name: Href
}

// MARK: - Episodes
struct Episodes: Codable {
    let href: String
    let limit: Int
    let next: String
    let offset: Int
    let previous: String
    let total: Int
    let items: [EpisodesItem]
}

// MARK: - EpisodesItem
struct EpisodesItem: Codable {
    let audioPreviewURL: String
    let description, htmlDescription: String
    let durationMS: Int
    let explicit: Bool
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let images: [SearchImage]
    let isExternallyHosted, isPlayable: Bool
    let language: String
    let languages: [String]
    let name, releaseDate, releaseDatePrecision: String
    let resumePoint: ResumePoint
    let type, uri: String
    let restrictions: Restrictions

    enum CodingKeys: String, CodingKey {
        case audioPreviewURL = "audio_preview_url"
        case description
        case htmlDescription = "html_description"
        case durationMS = "duration_ms"
        case explicit
        case externalUrls = "external_urls"
        case href, id, images
        case isExternallyHosted = "is_externally_hosted"
        case isPlayable = "is_playable"
        case language, languages, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case resumePoint = "resume_point"
        case type, uri, restrictions
    }
}

// MARK: - ResumePoint
struct ResumePoint: Codable {
    let fullyPlayed: Bool
    let resumePositionMS: Int

    enum CodingKeys: String, CodingKey {
        case fullyPlayed = "fully_played"
        case resumePositionMS = "resume_position_ms"
    }
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
    let description: Href
    let externalUrls: ExternalUrls
    let href, id: Href
    let images: [SearchImage]
    let name: Href
    let owner: Owner
    let itemPublic: Bool
    let snapshotID: Href
    let tracks: Followers
    let type, uri: Href

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
    let href, id: Href
    let type: String
    let uri, displayName: Href

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
    let next: String
    let offset: Int
    let previous: String
    let total: Int
    let items: [TracksItem]
}

// MARK: - TracksItem
struct TracksItem: Codable {
    let album: AlbumElement
    let artists: [ArtistElement]
    let availableMarkets: [Href]
    let discNumber, durationMS: Int
    let explicit: Bool
    let externalIDS: ExternalIDS
    let externalUrls: ExternalUrls
    let href, id: Href
    let isPlayable: Bool
    let linkedFrom: LinkedFrom
    let restrictions: Restrictions
    let name: Href
    let popularity: Int
    let previewURL: Href
    let trackNumber: Int
    let type: String
    let uri: Href
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
