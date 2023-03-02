//
//  HomeViewSpy.swift
//  SpotMusicTests
//
//  Created by Julian Marzabal on 02/03/2023.
//

import Foundation
@testable import SpotMusic

class HomeViewSpy:HomeViewDelegate {
    var selectPlaylistCalled = false
    var selectPlaylistValue:String?
    var toAddplaylistViewCalled = false
    func selectPlaylist(id: String) {
        selectPlaylistCalled = true
        selectPlaylistValue = id
    }
    
    func toAddPlaylistView() {
        toAddplaylistViewCalled = true
    }
    
    
    
}
