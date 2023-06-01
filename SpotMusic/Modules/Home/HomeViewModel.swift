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
fileprivate enum ScreenText {
    static let title = "Explore your Playlist"
    static let navigationTitle = "Search"
    
}
class HomeViewModel {
    // MARK: - Variables
    weak var delegate: HomeViewDelegate?
    var onSuccessfullUpdateReaction:  (() -> Void)?
    private (set) var playlistHomeModel: [PlaylistsHomeModel] = []
    private var api:APIProtocol = API.shared
    private var userID = SpotMusicCredentials.userID
    
    private (set) var title = ScreenText.title
    private (set) var navigationtitle = ScreenText.navigationTitle
    
    // MARK: - Public Methods
    
    func configureObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(getPlaylist), name: .init(rawValue: "playlistObserver"), object: nil)
    }
    
     func updateViewModel() {
       getPlaylist()
    }
    
     func selectPlaylistBy(index: Int) {
         guard playlistHomeModel.count >= index else {return}
         let playlist = playlistHomeModel[index]
         delegate?.selectPlaylist(id: playlist.id, isOwner: playlist.isOwner)
    }
    
    // MARK: - Private Methods
    
    private func createModel(playlist: [UserPlaylist]){
        
        playlistHomeModel = []
        print(SpotMusicCredentials.clientID)
        for track in playlist {
            playlistHomeModel.append(.init(description: track.description, id: track.id, images:track.images, name: track.name, isOwner: track.owner.id == userID  ))
        }
        
    }
    @objc private func getPlaylist() {
     
       api.getUserPlaylist { [weak self] results in
           switch results {
           case .success(let playlists):
               self?.createModel(playlist: playlists.items)
               self?.onSuccessfullUpdateReaction?()
           case .failure(let error):
               print(error)
           }
       }
    }
}
