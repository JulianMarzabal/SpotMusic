//
//  APIMOCK.swift
//  SpotMusicTests
//
//  Created by Julian Marzabal on 02/03/2023.
//

import Foundation
@testable import SpotMusic


class ApiMock:APIProtocol {
    var accesTokenResponse: Result<AuthenticationResponse, Error>?
    var userPlaylistResponse: Result<UserPlaylistResponse, Error>?
    
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
        
    }
    
    func searchItem(nameItem: String, completion: @escaping (Result<SearchItem, Error>) -> Void) {
        
    }
    
    
}
