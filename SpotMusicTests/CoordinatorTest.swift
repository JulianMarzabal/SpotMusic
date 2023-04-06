//
//  CoordinatorTest.swift
//  SpotMusicTests
//
//  Created by Julian Marzabal on 09/03/2023.
//

import XCTest
@testable import SpotMusic

class CoordinatorTest: XCTestCase {
    var sut: MainCoordinator!
    var navigationController: NavigationControllerMock!

    override func setUpWithError() throws {
        navigationController = .init()
        sut = .init(navigationController: navigationController)
  
    }

    override func tearDownWithError() throws {
        sut = nil
        navigationController = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStart() throws {
        
        sut.start()
        XCTAssertNotNil(navigationController.pushedViewController as? HomeViewController)
    }
    
    func testSelectPlaylist() throws {
        
        sut.selectPlaylist(id: "2", isOwner: true)
        
        XCTAssertNotNil(navigationController.pushedViewController as? PlaylistViewController)
        
    }
    func testToAddView() throws {
        sut.toAddPlaylistView()
        
        XCTAssertNotNil(navigationController.pushedViewController as? AddPlaylistViewController)
        
    }

    

}
