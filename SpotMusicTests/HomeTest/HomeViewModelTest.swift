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
        api.userPlaylistResponse = .success(.init(items: [.init(collaborative: true, owner: OwnerPlaylist.init(id: "2"), description: "good", externalUrls: "", href: "122334", id: "2", images: [], name: "duro de matar", userPlaylistPublic: true, snapshotID: "", type: "movie", uri: "")]))
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
        
        api.userPlaylistResponse = .success(.init(items: [.init(collaborative: true, owner: OwnerPlaylist.init(id: "2"), description: "good", externalUrls: "", href: "122334", id: "2", images: [], name: "duro de matar", userPlaylistPublic: true, snapshotID: "", type: "movie", uri: "")]))

       
        sut.getPlaylist()
        let expectation = XCTestExpectation(description: "se espera llenar el array de playlist response")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.sut.selectPlaylistBy(index: 0)
           
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 2)
        XCTAssert(self.spy.selectPlaylistCalled)
        XCTAssertEqual(self.spy.selectPlaylistValue, "2","El Id de la respuesta deberia ser igual a 2")
        
        
        
        
      
        
    }

}
