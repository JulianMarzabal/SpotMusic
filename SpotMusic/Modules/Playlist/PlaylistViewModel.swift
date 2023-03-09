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
    var audioModule: AudioModuleProtocol = AudioModule()
    var musicSound: AVAudioPlayer?
    var cellModel: [PlaylistTableViewModel] = []
    var footerModel: [FooterMusicViewModel] = []
    var api:APIProtocol = API.shared
 
    var songPlaying: String?
    var playlistID: String
    var onImageChange: ((String) -> Void)?
    var onplayingMusic: (()-> Void)?
    var onStopMusic: (() -> Void)?
    var onProgressMusic: ((Float) -> Void)?
   
    
    
    
    init(playlistID:String){
        self.playlistID = playlistID
    }
    
    
    func updateCells() {
       cellModel = myPlaylistModel.map {[weak self] model in
            PlaylistTableViewModel.init(isPlaying: model.name == songPlaying, nameSong: model.name, urlImage: model.imageURL, handler: {[weak self] in self?.handleSong(myplaylistSong: model)})
           
        }
        self.onSuccessfullUpdateReaction?()
    }
    
    func updateFooterMusic() {
        footerModel = myPlaylistModel.map({ [weak self] model in
            FooterMusicViewModel.init(isPlaying: model.name == songPlaying, nameSong: model.name, urlImage: model.imageURL, handler: {[weak self] in self?.handleSong(myplaylistSong: model)})
        })
        self.onSuccessfullUpdateReaction?()
    }
    
    
    func handleSong(myplaylistSong: myPlaylistModel){
        if let songPlaying = songPlaying {
            if songPlaying == myplaylistSong.name {
                audioModule.stopMusic()
                self.songPlaying = nil
            updateCells()
                return 
            }
        }
        
        guard let url = URL(string: myplaylistSong.previewURL) else {return}
        songPlaying = myplaylistSong.name
         
        audioModule.loadMusic(url: url)
        self.updateCells()
        
    }

    
    func getPlaylistByID() {
        api.getPlaylistDetails(playlistID: playlistID) { [weak self] results in
            switch results {
            case .success(let playlistByID):
                self?.playlistByID = playlistByID.itemsList
                self?.createModel()
                self?.updateCells()
                self?.updateFooterMusic()
                self?.onImageChange?(playlistByID.itemsList.first?.track.album.images.first?.url ?? "")
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
   
        
    
    }
  
    func updateViewModel() {
        createModel()

        onSuccessfullUpdateReaction?()
        
    }
    
    func listenSongBy(index:Int) {
    
   
        
    }
    
}
    
