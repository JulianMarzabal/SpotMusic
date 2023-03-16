//
//  AddplaylistViewControllerTest.swift
//  SpotMusicTests
//
//  Created by Julian Marzabal on 12/03/2023.
//

import XCTest
@testable import SpotMusic

class AddplaylistViewControllerTest: XCTestCase {
    var sut: addPlaylistViewController!
    var viewmodel: AddPlaylistViewModel!

    override func setUpWithError() throws {
    viewmodel = AddPlaylistViewModel()
    sut = addPlaylistViewController(viewmodel: viewmodel)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testViewDidLoad() throws {
        sut.viewDidLoad()
        
        XCTAssertNotNil(sut.viewDidLoad())
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
