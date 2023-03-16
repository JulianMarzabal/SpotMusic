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

    func testViewDidLoad() throws {
        sut.viewDidLoad()
        
        XCTAssertNotNil(sut.tableView)
        XCTAssertNotNil(sut.setupContraints)
    }
    
    func testViewWillApper() throws {
        var isUpdateViewModel = false
        viewModelMock.onSuccessfullUpdateReaction = {
            isUpdateViewModel = true
        }
        sut.viewWillAppear(true)
        
        XCTAssert(isUpdateViewModel)
    }
    
    func testViewWillLayoutSubviews() throws {
        let expectedFrame = sut.view.bounds
        
        sut.viewWillLayoutSubviews()
        
        XCTAssertEqual(sut.tableView.frame, expectedFrame)
    }
    
    func testTableView_CellForRowAt() throws {
        let mockModel = SearchModel(name: "As it was", previewURL: "http//google.com", popularity: 50, image: "image1", artist: "Harry Styles")
        
        viewModelMock.searchModel = [mockModel]
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! SearchItemTableViewCell
        
        XCTAssertEqual(cell.titleSongLabel.text, mockModel.name)
        XCTAssertEqual(cell.artistLabel.text, mockModel.artist)
    }
    
}

