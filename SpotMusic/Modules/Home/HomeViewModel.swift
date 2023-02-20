//
//  HomeViewModel.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 22/01/2023.
//

import Foundation

protocol HomeViewDelegate:AnyObject {
    func selectPlaylist(id:String)
    func toAddPlaylistView()
    
}

class HomeViewModel {
    weak var delegate: HomeViewDelegate?
    var playlist: [UserPlaylist] = [UserPlaylist]()
    //var imagePlaylist: [UserPlaylistImage] = [UserPlaylistImage]()
    var onSuccessfullUpdateReaction:  (() -> Void)?
    var playlistHomeModel: [PlaylistsHomeModel] = []
    
    
   func getPlaylist() {
     
       API.shared.getUserPlaylist { [weak self] results in
           switch results {
           case .success(let playlists):
               print("all is ok")
               self?.playlist = playlists.items
               self?.createModel()
               self?.onSuccessfullUpdateReaction?()
               
               DispatchQueue.main.async {
                   print("get playlist Dispatch")
               }
           case .failure(let error):
               print(error)
           }
       }
    }
    private func createModel(){
        playlistHomeModel = []
        for track in playlist {
            playlistHomeModel.append(.init(description: track.description, id: track.id, images:track.images, name: track.name))
        }
        
        
    }
    
    func updateViewModel() {
        createModel()
        onSuccessfullUpdateReaction?()
    }
    
    func selectPlaylistBy(id: String) {
       
        delegate?.selectPlaylist(id: id)
    }
    
}
