//
//  HomeViewModel.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 22/01/2023.
//

import Foundation

protocol HomeViewDelegate:AnyObject {
    func selectPlaylist(id:String,isOwner:Bool)
    func toAddPlaylistView()
    
}

class HomeViewModel {
    weak var delegate: HomeViewDelegate?
    var playlist: [UserPlaylist] = [UserPlaylist]()
    //var imagePlaylist: [UserPlaylistImage] = [UserPlaylistImage]()
    var onSuccessfullUpdateReaction:  (() -> Void)?
    var playlistHomeModel: [PlaylistsHomeModel] = []
    var api:APIProtocol = API.shared
    var userID = SpotMusicCredentials.userID
    
    func configureObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(getPlaylist), name: .init(rawValue: "playlistObserver"), object: nil)
    }
    
    
    @objc func getPlaylist() {
     
       api.getUserPlaylist { [weak self] results in
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
        print(SpotMusicCredentials.clientID)
        for track in playlist {
            playlistHomeModel.append(.init(description: track.description, id: track.id, images:track.images, name: track.name, isOwner: track.owner.id == userID  ))
        }
        
        
    }
    
     func updateViewModel() {
        createModel()
        onSuccessfullUpdateReaction?()
    }
    
     func selectPlaylistBy(index: Int) {
         let playlist = playlistHomeModel[index]
       
         delegate?.selectPlaylist(id: playlist.id, isOwner: playlist.isOwner)
    }
    
}
