//
//  HomeViewControllerTest.swift
//  SpotMusicTests
//
//  Created by Julian Marzabal on 12/03/2023.
//

import XCTest
@testable import SpotMusic

class HomeViewControllerTest: XCTestCase {
    var sut: HomeViewController!
    var viewModel: HomeViewModel!
    

    override func setUpWithError() throws {
        viewModel = HomeViewModel()
        sut = HomeViewController(viewModel: viewModel)
        sut.viewModel = viewModel
        sut.collectionView.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: MusicCollectionViewCell.identifier)
    }

    override func tearDownWithError() throws {
      viewModel = nil
        sut = nil
    }

    func testCollectionView_cellForItemAt() throws {
        let mockModel = PlaylistsHomeModel(description: "best songs ever", id: "4", images: nil, name: "Exitos Argentina")
        sut.viewModel.playlistHomeModel = [mockModel]
        
        
        let cell = sut.collectionView(sut.collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as! MusicCollectionViewCell
        
        XCTAssertEqual(cell.genreLabel.text, mockModel.name)
        
        
    }


}
