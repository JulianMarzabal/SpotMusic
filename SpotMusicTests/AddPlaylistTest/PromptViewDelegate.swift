//
//  PromptViewDelegate.swift
//  SpotMusicTests
//
//  Created by Julian Marzabal on 15/03/2023.
//

import Foundation
@testable import SpotMusic


class PromptDelegateMock: PromptPlaylistCreatedDelegate {
    var toHomeViewControllerHasBeenCalled = false
    func toHomeViewController() {
    toHomeViewControllerHasBeenCalled = true
    }
    
    
}
