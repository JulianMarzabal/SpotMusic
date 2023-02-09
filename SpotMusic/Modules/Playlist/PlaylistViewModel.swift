//
//  PlaylistViewModel.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 31/01/2023.
//

import Foundation
import SDWebImage
import AVFoundation

class PlaylistViewModel {
    var playlistByID: [Item] = [Item]()
    var myPlaylistModel: [myPlaylistModel] = []
    var onSuccessfullUpdateReaction:  (() -> Void)?
    var musicSound: AVAudioPlayer?
    
    
    
    func getPlaylistByID() {
        API.shared.getPlaylistDetails { [weak self] results in
            switch results {
            case .success(let playlistByID):
                self?.playlistByID = playlistByID.itemsList
                self?.createModel()
                self?.onSuccessfullUpdateReaction?()
                print("PlaylistByid ok")
                //7self?.createModel()
            case .failure(let error):
                print(error)
                
            }
            
        }
    }
    
    
    func createModel() {
  
       print("model creado")
        myPlaylistModel = []
        
        for item in playlistByID {
            myPlaylistModel.append(.init(name: item.track.name, description: item.track.name, previewURL: item.track.preview_url ?? "", imageURL: item.track.album.images.first?.url ?? ""))
        }
        
    print(myPlaylistModel)
        
    
    }
    
    func updateViewModel() {
        createModel()
        onSuccessfullUpdateReaction?()
    }
    
    
    
    
    func playmusic(url:URL) {
     
        
        do {
            musicSound = try AVAudioPlayer(contentsOf: url)
            musicSound?.play()
        }catch{
            
        }
    
    }
}
    
