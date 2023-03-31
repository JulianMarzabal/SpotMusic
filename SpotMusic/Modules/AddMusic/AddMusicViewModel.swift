//
//  AddMusicViewModel.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 26/03/2023.
//

import Foundation


class AddMusicViewModel {
    
    var api:APIProtocol = API.shared
    
    
    
    func getRecommendation() {
        api.getRecommendations { [weak self] result in
            switch result {
            case .success(let traks):
                let tracks = traks
                print(traks)
                print("get Recommendation")
            case .failure(let error):
                print("error \(error.localizedDescription)")
            }
        }
    }
    
    
}
