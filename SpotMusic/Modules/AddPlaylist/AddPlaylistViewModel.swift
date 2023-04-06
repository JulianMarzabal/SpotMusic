//
//  AddPlaylistViewModel.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 14/03/2023.
//

import Foundation




class AddPlaylistViewModel {
    
    var api:APIProtocol = API.shared
    var onSuccessfullUpdateReaction:  (() -> Void)?
    var newPlaylistID: String?
 
    
    func createPlaylist(name:String){
        api.createPlaylist(name: name, completion: {[weak self] result in
            switch result {
                case .success(let playlistNew):
                    let playlist = playlistNew.name
                self?.newPlaylistID = playlistNew.id
                
                    print(playlist)
                self?.onSuccessfullUpdateReaction?()
                NotificationCenter.default.post(name: .init(rawValue: "playlistObserver"), object: nil)
                
            
                case .failure(let error):
                print("error\(error.localizedDescription)")
            }
            
            
            
        })
        
    }
    
    
    
    
}
