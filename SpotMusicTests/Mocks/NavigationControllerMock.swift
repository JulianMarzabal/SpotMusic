//
//  NavigationControllerMock.swift
//  SpotMusicTests
//
//  Created by Julian Marzabal on 09/03/2023.
//

import Foundation
import UIKit



class NavigationControllerMock:UINavigationController {
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController 
    }
    
    
}
