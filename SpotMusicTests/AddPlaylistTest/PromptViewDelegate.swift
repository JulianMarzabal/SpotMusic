//
//  PromptViewDelegate.swift
//  SpotMusicTests
//
//  Created by Julian Marzabal on 15/03/2023.
//

import Foundation
@testable import SpotMusic
import UIKit


class PromptDelegateMock:UIView, PromptPlaylistCreatedDelegate {

    func onDoneTapped() {
        ""
    }
    
    var toHomeViewControllerHasBeenCalled = false
    func toHomeViewController() {
    toHomeViewControllerHasBeenCalled = true
    }
    
    
}
