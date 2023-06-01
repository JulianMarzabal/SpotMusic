//
//  HomeViewSpy.swift
//  SpotMusicTests
//
//  Created by Julian Marzabal on 02/03/2023.
//

import Foundation
@testable import SpotMusic

class HomeViewSpy:HomeViewDelegate {
    func selectPlaylist(id: String, isOwner: Bool) {
        selectPlaylistCalled = true
        selectPlaylistValue = id
    }
    
    var selectPlaylistCalled = false
    var selectPlaylistValue:String?
    var toAddplaylistViewCalled = false
    func selectPlaylist(id: String) {
        selectPlaylistCalled = true
        selectPlaylistValue = "2"
    }
    
    func toAddPlaylistView() {
        toAddplaylistViewCalled = true
    }
    
    
    
}
