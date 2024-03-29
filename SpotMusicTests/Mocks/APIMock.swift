//
//  APIMOCK.swift
//  SpotMusicTests
//
//  Created by Julian Marzabal on 02/03/2023.
//

import Foundation
@testable import SpotMusic


class ApiMock:APIProtocol {
    func createPlaylist(name: String, completion: @escaping (Result<CreatePlaylistResponse, Error>) -> Void) {
        
    }
    
    func getRecommendations(completion: @escaping (Result<TrackResponse, Error>) -> Void) {
        
    }
    
    func addItemToPlaylist(playlistID: String, uri: String, completion: @escaping (Result<AddItemResponse, Error>) -> Void) {
        
    }
    
    func getAccesTokenOauth(code: String, completion: @escaping (Result<OauthTokenResponse, Error>) -> Void) {
        
    }
    
    func getAuthorization() -> URLRequest? {
        return nil
    }
    
    var accesTokenResponse: Result<AuthenticationResponse, Error>?
    var userPlaylistResponse: Result<UserPlaylistResponse, Error>?
    var playlistDetailsByID: Result<PlaylistTrack, Error>?
    var searchResult: Result<SearchItem, Error>?
    
    func getAccessToken(completion: @escaping (Result<AuthenticationResponse, Error>) -> Void) {
        if let accesTokenResponse = accesTokenResponse {
            completion(accesTokenResponse)
        }
    }
    
    func getUserPlaylist(completion: @escaping (Result<UserPlaylistResponse, Error>) -> Void) {
        if let userPlaylistResponse = userPlaylistResponse {
            completion(userPlaylistResponse)
        }
    }
    
    func getPlaylistDetails(playlistID: String, completion: @escaping (Result<PlaylistTrack, Error>) -> Void) {
        if let playlistDetailsByID = playlistDetailsByID {
            completion(playlistDetailsByID)
        }
        
    }
    
    func searchItem(nameItem: String, completion: @escaping (Result<SearchItem, Error>) -> Void) {
        if let searchResult = searchResult {
            completion(searchResult)
        }
    }
    
    
}
