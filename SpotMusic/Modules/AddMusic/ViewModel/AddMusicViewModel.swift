//
//  AddMusicViewModel.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 26/03/2023.
//

import Foundation
protocol AddMusicViewModelDelegate:AnyObject {
    func navigateToHome()
    
}


class AddMusicViewModel {
    var id:String
    weak var delegate: AddMusicViewModelDelegate?
    var api:APIProtocol = API.shared
    var cellModel:[AddMusicTableViewModel] = []
    var trackRecommendationModel: [TrackRecommendationsModel] = []
    var songPlaying: String?
    var audioModule: AudioModuleProtocol
    var onSuccessfullUpdateReaction:  (() -> Void)?
    var playlistID:String?
    
    init(id:String,audioModule: AudioModuleProtocol =  AudioModule.shared){
        self.audioModule = audioModule
        self.id = id
    }
    
    func getRecommendation() {
        api.getRecommendations { [weak self] result in
            switch result {
            case .success(let tracks):
                self?.createModel(recommendations: tracks.tracks)
                self?.updateCells()
               
            case .failure(let error):
                print("error \(error.localizedDescription)")
            }
        }
    }
    func addItemToPlaylist(playlistID:String,uri:String) {
        
        api.addItemToPlaylist(playlistID: playlistID, uri: uri, completion: { [weak self] result in
            switch result {
            case .success(let addItem):
                let item = addItem
                print("Add item done")
            case .failure(let error):
                print("error \(error.localizedDescription)")
                
            }
            
            
        })
    }
    func updateCells() {
        cellModel = trackRecommendationModel.map { [weak self] model in
            AddMusicTableViewModel(
                isPlaying: false,
                nameSong: model.name,
                uri: model.uri,
                playlistID: model.id,
                image: model.image,
                
                handler: { [weak self] in
                    guard let self = self else {return}
                    self.addItemToPlaylist(playlistID:self.id , uri: model.uri)
                }
            )
        }
        
        self.onSuccessfullUpdateReaction?()
    }

    func handleSong(addRecomendationSong:TrackRecommendationsModel){
        
        if let songPlaying = songPlaying {
            if songPlaying == addRecomendationSong.name {
                audioModule.stopMusic()
                self.songPlaying = nil
            updateCells()
                return
            }
        }
        
        guard let url = URL(string: addRecomendationSong.previewUrl ?? "") else {return}
        songPlaying = addRecomendationSong.name
         
        audioModule.loadMusic(url: url)
        self.updateCells()
        
    }
    
    
    
    
    func createModel(recommendations:[TrackRecommendation]) {
        trackRecommendationModel = []
        
        for item in recommendations {
            trackRecommendationModel.append(.init(id: item.id, isPlayable: item.isPlayable, name: item.name, popularity: item.popularity, previewUrl: item.previewUrl, uri: item.uri, image: item.album.images.first?.url ?? ""))
            
        }
      
        
    }
    
    func updateViewModel() {
        getRecommendation()
    }
    
    
}




