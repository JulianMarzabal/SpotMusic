//
//  MainCoordinator.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 22/01/2023.
//

import Foundation
import UIKit

class MainCoordinator {
    
    var navigationController: UINavigationController
    init(navigationController:UINavigationController){
        self.navigationController = navigationController
    }
    func start() {
        let vm = HomeViewModel()
        vm.delegate = self
        let vc = HomeViewController(viewModel: vm)
        
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    
    
}

extension MainCoordinator: HomeViewDelegate {
    func selectPlaylist(index:Int) {
        let vm = PlaylistViewModel()
        let vc = PlaylistViewController(viewmodel: vm)
        print("celda1")
        navigationController.pushViewController(vc, animated: false)
    }
    
    
}
