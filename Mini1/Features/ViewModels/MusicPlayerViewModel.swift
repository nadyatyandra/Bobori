//
//  MusicPlayerViewModel.swift
//  Mini1
//
//  Created by Leo Harnadi on 01/05/23.
//

import Foundation
import AVFoundation

class MusicPlayerViewModel: ObservableObject {
    @Published var musicPlayerModel = MusicPlayerModel()
    
    var songPlayer: AVAudioPlayer?
    
    
    
    func playSong() {
        guard let url = Bundle.main.url(forResource: musicPlayerModel.selectedSong, withExtension: "mp3") else { return }
        
        do {
            songPlayer = try AVAudioPlayer(contentsOf: url)
            songPlayer?.numberOfLoops = -1
            songPlayer?.volume = 1
            songPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
        
    }
    
    func stopSong() {
        songPlayer?.stop()
    }
    
}
