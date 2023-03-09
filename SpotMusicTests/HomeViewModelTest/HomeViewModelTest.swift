//
//  SpotMusicTests.swift
//  SpotMusicTests
//
//  Created by Julian Marzabal on 02/03/2023.
//

import XCTest
@testable import SpotMusic


class HomeviewModelTest: XCTestCase {
    var sut: HomeViewModel!
    var api: ApiMock!
    var spy: HomeViewSpy!
    
    
    override func setUpWithError() throws {
        sut = .init()
        api = ApiMock()
        spy = .init()
        sut.api = api
        sut.delegate = spy
    
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        api = nil
        spy = nil
    }

    func testGetUserPlaylist() throws {
        var callBackHasbeenCalled = false
        api.userPlaylistResponse = .success(.init(items: [.init(collaborative: true, description: "good", externalUrls: "", href: "122334", id: "2", images: [], name: "duro de matar", userPlaylistPublic: true, snapshotID: "", type: "movie", uri: "")]))
        sut.onSuccessfullUpdateReaction = {
            callBackHasbeenCalled = true
        }
        //When
        sut.getPlaylist()
        
        //Then
        XCTAssert(callBackHasbeenCalled)
        XCTAssert(sut.playlistHomeModel.count == 1)
  
    }
    
    func testGetUserPlaylistFailure() throws {
        var callBackHasbeenCalled = false
        api.userPlaylistResponse = .failure(SpotiError.badResponse)
        sut.onSuccessfullUpdateReaction = {
            callBackHasbeenCalled = true
        }
        sut.getPlaylist()
        
        XCTAssertFalse(callBackHasbeenCalled)
    }

    func testUpdateViewModel() throws {
        var updateViewModelSuccess = false
        sut.onSuccessfullUpdateReaction = {
            updateViewModelSuccess = true
        }
        sut.updateViewModel()
        
        XCTAssert(updateViewModelSuccess)
        
    }
    
    func testSelectPlaylistByID() throws {
        let playlistID = "2"
                
        sut.delegate?.selectPlaylist(id: playlistID)
       
        
        XCTAssert(spy.selectPlaylistCalled)
        XCTAssertEqual(spy.selectPlaylistValue, playlistID)
      
        
    }

}
