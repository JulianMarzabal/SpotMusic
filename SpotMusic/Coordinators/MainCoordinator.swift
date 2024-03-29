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
        let searchVM = SearchResultViewModel()
        searchVM.delegate = self
        vm.delegate = self
        let searchVC = SearchResultsViewController(viewModel: searchVM)
        let vc = HomeViewController(viewModel: vm, searchResultViewController: searchVC)
 
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
        vm.delegate = self
        
        let vc = PlaylistViewController(viewmodel: vm)
        print("celda1")
        navigationController.pushViewController(vc, animated: false)
    }
    
}

extension MainCoordinator:AddPlaylistViewControllerDelegate {
    func onNewPlaylistCreated(id:String) {
        let vm = AddMusicViewModel(id: id)
        vm.delegate = self
        let vc = AddMusicViewController(viewmodel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
extension MainCoordinator: AddMusicViewModelDelegate {
    func navigateToHome() {
       start()
    }
    
    
}
extension MainCoordinator: PlaylistViewModelDelegate {
    func navigateToAddTrackToPlaylist(id: String) {
     onNewPlaylistCreated(id: id)
    }
    
    
    
    
    
}

extension MainCoordinator: SearchViewDelegate {
    func toDescriptionSong() {
        
        let vc = DescriptionViewController()
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}


    
    

    
    


    
    

