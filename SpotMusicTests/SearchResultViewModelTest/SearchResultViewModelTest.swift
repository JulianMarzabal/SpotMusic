//
//  SearchResultViewModelTest.swift
//  SpotMusicTests
//
//  Created by Julian Marzabal on 05/03/2023.
//

import XCTest
@testable import SpotMusic

class SearchResultViewModelTest: XCTestCase {
    var sut: SearchResultViewModel!
    var api: ApiMock!

    override func setUpWithError() throws {
        sut = .init()
        api = ApiMock()
        sut.api = api
    }

    override func tearDownWithError() throws {
        sut = nil
        api = nil
    }

    func testSearchItemResult() throws {
       var callbackHasBeenCalled = false
        let tracksItem = TracksItem(album: .init(albumType: "", totalTracks: 3, availableMarkets: [], externalUrls: .init(spotify: ""), href: "", id: "2", images: [], name: "test1", releaseDate: "", releaseDatePrecision: "", restrictions: nil, type: "", uri: "", copyrights: nil, externalIDS: nil, genres: nil, label: nil, popularity: nil, albumGroup: nil, artists: []), artists: [], availableMarkets: [], discNumber: 10, durationMS: 20, explicit: true, externalIDS: .init(isrc: nil, ean: nil, upc: nil), externalUrls: .init(spotify: ""), href: "", id: "2", isPlayable: nil, linkedFrom: nil, restrictions: nil, name: "test1", popularity: 10, previewURL: "", trackNumber: 20, type: "", uri: "", isLocal: false)
        let tracksItemArray = [tracksItem]
        let tracks = Tracks(href: "", limit: 10, next: nil, offset: 20, previous: nil, total: 20, items: tracksItemArray)
        api.searchResult = .success(.init(tracks:tracks , artists: nil, albums: nil, playlists: nil))
        
        sut.onSuccessfullUpdateReaction = {
            callbackHasBeenCalled = true
        }
        sut.searchItemResult()
        
        XCTAssert(callbackHasBeenCalled)
    }
    
    func testUpdateViewModel() throws {
        var callbackHasBeenCalled = false
        sut.onSuccessfullUpdateReaction = {
            callbackHasBeenCalled = true
        }
        
        sut.updateViewModel()
        XCTAssert(callbackHasBeenCalled)
    }
    
    func testObserver() throws {
        let object = "text"
        sut.text = object
        
        
        
        XCTAssertEqual(sut.text, object)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
