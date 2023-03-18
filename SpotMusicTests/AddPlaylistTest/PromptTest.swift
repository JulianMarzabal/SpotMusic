//
//  PromptTest.swift
//  SpotMusicTests
//
//  Created by Julian Marzabal on 15/03/2023.
//

import XCTest
@testable import SpotMusic

class PromptTest: XCTestCase {
    var sut: PromptPlaylistCreatedView!
    var delegate: PromptDelegateMock!

    override func setUpWithError() throws {
        sut = PromptPlaylistCreatedView(onTapped: {})
        delegate = PromptDelegateMock()
       
    }

    override func tearDownWithError() throws {
        sut = nil
        delegate = nil
    }

    
    func testLabelConfiguration() {
        XCTAssertEqual(sut.label.text, "Playlist created succesfully")
        XCTAssertEqual(sut.label.textColor, .white)
        XCTAssertEqual(sut.label.textAlignment, .center)
    }

    func testButtonConfiguration() {
        XCTAssertEqual(sut.button.title(for: .normal), "OK")
        XCTAssertEqual(sut.button.titleColor(for: .normal), UIColor.black)
        XCTAssertEqual(sut.button.layer.cornerRadius, 9)
        XCTAssertEqual(sut.button.tintColor, .white)
    }
   

    

}
