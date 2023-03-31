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
    func toAddPlaylistView() {
        let vm = AddPlaylistViewModel()
        let vc = AddPlaylistViewController(viewmodel: vm)
        vc.delegate = self
      
        navigationController.pushViewController(vc, animated: false)
    }
    
    func selectPlaylist(id:String,isOwner:Bool) {
        let vm = PlaylistViewModel(playlistID: id, isOwner: isOwner)
        let vc = PlaylistViewController(viewmodel: vm)
        print("celda1")
        navigationController.pushViewController(vc, animated: false)
    }
    
}

extension MainCoordinator:AddPlaylistViewControllerDelegate {
    func onNewPlaylistCreated() {
        let vm = AddMusicViewModel()
        let vc = AddMusicViewController(viewmodel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}


    
    

    
    


    
    

