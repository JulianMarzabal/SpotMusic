//
//  SpotMusicTests.swift
//  SpotMusicTests
//
//  Created by Julian Marzabal on 02/03/2023.
//

import XCTest
@testable import SpotMusic


class SpotMusicTests: XCTestCase {
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

    func testExample() throws {
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
    
    func testFailure() throws {
        var callBackHasbeenCalled = false
        api.userPlaylistResponse = .failure(SpotiError.badResponse)
        sut.onSuccessfullUpdateReaction = {
            callBackHasbeenCalled = true
        }
        sut.getPlaylist()
        
        XCTAssertFalse(callBackHasbeenCalled)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
