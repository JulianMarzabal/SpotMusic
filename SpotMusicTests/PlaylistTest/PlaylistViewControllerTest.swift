//
//  PlaylistViewControllerTest.swift
//  SpotMusicTests
//
//  Created by Julian Marzabal on 09/03/2023.
//

import XCTest
@testable import SpotMusic

class PlaylistViewControllerTest: XCTestCase {
    var sut: PlaylistViewController!
    var viewmodel: PlaylistViewModelMock!
    

    override func setUpWithError() throws {
        viewmodel = PlaylistViewModelMock(playlistID: "2")
        sut = PlaylistViewController(viewmodel: viewmodel)
        sut.viewmodel = viewmodel
        sut.tableView.register(PlaylistTableViewCell.self, forCellReuseIdentifier: PlaylistTableViewCell.identifier)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        viewmodel = nil
    }

    func testBindReaction() throws {
      var isReloadDataCalled = false
        viewmodel.onSuccessfullUpdateReaction = {
            isReloadDataCalled = true
        }
        sut.bindReaction()
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
             XCTAssert(isReloadDataCalled)
         }

    }
    func testSetupUI() throws {
        
        sut.setupUI()
        XCTAssertNotNil(sut.tableView)
        XCTAssertNotNil(sut.imagView)
        
        
    }

    func testUpdateViewController()  {
 
        sut.viewWillAppear(true)
        
        do {
              try viewmodel.updateViewModel()
              XCTAssertTrue(true)
          } catch {
              // Si hay errores, la llamada a updateViewModel falló
              XCTFail("Error actualizando el viewmodel: \(error.localizedDescription)")
          }
    }
    func testTableViewCell() throws {
        
        let mockmodel = PlaylistTableViewModel(isPlaying: false, nameSong: "As it Was", urlImage: "", handler: {})
        sut.viewmodel.cellModel = [mockmodel]
        
        XCTAssertTrue(sut.tableView.numberOfRows(inSection: 0) > 0)
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! PlaylistTableViewCell
        
        XCTAssertEqual(cell.titleSongLabel.text, mockmodel.nameSong)
        
    }
    

}
