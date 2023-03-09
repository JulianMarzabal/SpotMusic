//
//  AudioModuleMock.swift
//  SpotMusicTests
//
//  Created by Julian Marzabal on 09/03/2023.
//

import Foundation
@testable import SpotMusic


class AudioModuleMock: AudioModuleProtocol  {
    var loadMusicCalled = false
    var stopMusicCalled = false
    func loadMusic(url: URL) {
        loadMusicCalled = true
    }
    
    func stopMusic() {
        stopMusicCalled = true
    }
    
    
    
}
