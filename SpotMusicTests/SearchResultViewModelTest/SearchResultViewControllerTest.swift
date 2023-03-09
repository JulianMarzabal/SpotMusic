//
//  SearchResultViewControllerTest.swift
//  SpotMusicTests
//
//  Created by Julian Marzabal on 06/03/2023.
//

import XCTest
@testable import SpotMusic


class SearchResultViewControllerTest: XCTestCase {
    var sut: SearchResultsViewController!
    var viewModelMock: SearchResultViewModelMock!
    override func setUpWithError() throws {
        viewModelMock = SearchResultViewModelMock()
        sut = .init(viewModel: viewModelMock)
        sut.viewModel = viewModelMock
        
      
    }

    override func tearDownWithError() throws {
        
        sut = nil
        viewModelMock = nil
    }

    func testBindReaction() throws {
        var isReloadDataCalled = false
        viewModelMock.onSuccessfullUpdateReaction = {
            isReloadDataCalled = true
        }
        sut.bindReaction()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
             XCTAssert(isReloadDataCalled)
         }
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
