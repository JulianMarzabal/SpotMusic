//
//  AudioModule.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 09/02/2023.
//

import Foundation
import AVFAudio



class AudioModule {
   
    
    var audioPlayer: AVAudioPlayer = .init()
    
    func loadMusic(url:URL) {
        if audioPlayer.isPlaying {
            audioPlayer.stop()
        }
        do {
            let  data = try Data(contentsOf: url)
            try audioPlayer = .init(data: data)
            audioPlayer.play()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func stopMusic() {
        audioPlayer.stop()
    
    }
    
    
    
    
    
    
}