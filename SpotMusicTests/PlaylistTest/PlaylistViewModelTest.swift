//
//  PlaylistHomeViewModelTest.swift
//  SpotMusicTests
//
//  Created by Julian Marzabal on 05/03/2023.
//

import XCTest
@testable import SpotMusic

class PlaylistViewModelTest: XCTestCase {
    var sut: PlaylistViewModel!
    var api: ApiMock!
    var audioModuleMock: AudioModuleMock!
    

    override func setUpWithError() throws {
        sut = .init(playlistID: "2", isOwner: true)
        api = ApiMock()
        audioModuleMock = AudioModuleMock()
        sut.audioModule = audioModuleMock
        sut.api = api
    }

    override func tearDownWithError() throws {
        sut = nil
        api = nil
        audioModuleMock = nil
    }

    func testGetPlaylistByID() throws {
        var callBackHasbeenCalled = false
        api.playlistDetailsByID = .success(.init(href: "", limit: 2, next: "asitwas", offset: 10, previous: "", total: 20, itemsList: []))
        
                                           
        sut.onSuccessfullUpdateReaction = {
            callBackHasbeenCalled = true
        }
        
        //when
        sut.getPlaylistByID()
        
        //then
        XCTAssert(callBackHasbeenCalled)
        //XCTAssert(sut.myPlaylistModel.count == 1)
        
        
    }

    func testCreateModel() throws {
        var modelHasBeenCreated = false
        let albumMock = Album(total_tracks: 30, available_markets: [], href: "", id: "2", images: [], name: "", release_date: "", release_date_precision: "", type: "", uri: "", label: nil)
        let trackMock = Track(album:albumMock , available_markets: [], disc_number: 10, duration_ms: 10, explicit: true, href: "", id: "2", name: "test", popularity: 50, preview_url: "", track_number: 10, type: "", uri: "", is_local: false)
       
        let itemMock = Item(addedAt: nil, isLocal: nil, track: trackMock)
       let itemMockArray = [itemMock]
        sut.playlistByID = itemMockArray
        //Create and update
        sut.createModel()
        sut.updateViewModel()
        sut.onSuccessfullUpdateReaction = {
            modelHasBeenCreated = true
        }
        
        XCTAssert(sut.myPlaylistModel.count == 1)
        XCTAssertEqual(sut.myPlaylistModel[0].name, "test")
            
        }
    
    func testUpdateCells() throws {
        var myPlaylistMock = sut.myPlaylistModel
       myPlaylistMock = [
       myPlaylistModel(name: "los palmeras", description: "cumbia", previewURL: "previewurl", imageURL: "image1"),
       myPlaylistModel(name: "axel", description: "romanticos", previewURL: "previewurl1", imageURL: "image2")
       ]
        sut.myPlaylistModel = myPlaylistMock
       var updateCellsHasBeenDone = false
        
        sut.updateCells()
        
        sut.onSuccessfullUpdateReaction = {
            updateCellsHasBeenDone = true
        }
        XCTAssertEqual(sut.cellModel.count, 2)
        
        //XCTAssert(updateCellsHasBeenDone)
        
    }
    
    
    func testHandleSong() throws {
        let playlist = myPlaylistModel(name: "as it was", description: "pop", previewURL: "", imageURL: "image1")
        sut.songPlaying = playlist.name
        sut.handleSong(myplaylistSong: playlist)
        
        XCTAssert(audioModuleMock.stopMusicCalled,"Should call stopMusic")
        XCTAssertFalse(audioModuleMock.loadMusicCalled,"Should not call loadMusic")
        
        
        }
    
    func testHandleSong_LoadMusic() throws {
        let playlist = myPlaylistModel(name: "as it was", description: "pop", previewURL: "http://google.com", imageURL: "http://google.com")
        sut.songPlaying = "ass"
        sut.handleSong(myplaylistSong: playlist)
        
        XCTAssert(audioModuleMock.loadMusicCalled,"Should call loadMusic")
        XCTAssertFalse(audioModuleMock.stopMusicCalled,"Should not call stopMusic ")
        
    }
        
    
        
        
     
        //XCTAssertFalse(audioModule.audioPlayer.isPlaying)
        //XCTAssertEqual(sut.songPlaying, playlist.name)
        
        
    
        
        
    

}
