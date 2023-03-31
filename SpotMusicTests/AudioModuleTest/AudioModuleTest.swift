//
//  AudioModuleTest.swift
//  SpotMusicTests
//
//  Created by Julian Marzabal on 15/03/2023.
//

import XCTest
@testable import SpotMusic

class AudioModuleTest: XCTestCase {
    var sut: AudioModule!
    override func setUpWithError() throws {
        sut = AudioModule()
    
        
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLoadAndStopMusic() {
            guard let url = Bundle(for: Self.self).url(forResource: "audioPrueba", withExtension: "mp3") else {
                XCTFail("Test audio file not found")
                return
            }
            
            sut.loadMusic(url: url)
            
           // XCTAssertTrue(sut.audioPlayer.isPlaying, "Audio player should be playing after calling loadMusic")
            
            sut.stopMusic()
            
            XCTAssertFalse(sut.audioPlayer.isPlaying, "Audio player should not be playing after calling stopMusic")
        }

}
