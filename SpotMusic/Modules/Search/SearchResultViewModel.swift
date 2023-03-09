//
//  SearchResultViewModel.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 26/02/2023.
//

import Foundation


class SearchResultViewModel{
    
    var searchItem:[TracksItem] = [TracksItem]()
    var searchModel:[SearchModel] = []
    var api:APIProtocol = API.shared
   
    var onSuccessfullUpdateReaction:  (() -> Void)?
    public var text: String = ""{
        didSet{
            self.searchItemResult()
        }
    }
    
   
    
    
    
    func searchItemResult(){
        
        api.searchItem(nameItem: self.text) { [weak self] responses in
            switch responses {
            case .success(let items):
                self?.searchItem = items.tracks.items
                self?.createModel()
                self?.onSuccessfullUpdateReaction?()
                print("search succesful")
                
                
            case .failure(let error):
                print("error\(error)")
            }
        }
       
        
    }
   
    private func createModel() {
        searchModel = []
        for item in searchItem {
            searchModel.append(.init(name: item.name, previewURL: item.previewURL, popularity: item.popularity, image: item.album.images.first?.url ?? "", artist: item.artists.first?.name ?? ""))
            
            
        }
        print("model creado \(searchModel)")
    }
    func updateViewModel() {
        createModel()
        onSuccessfullUpdateReaction?()
    }
    
    
    
    
    
    
}
