//
//  MusicPlayerViewModel.swift
//  Mini1
//
//  Created by Leo Harnadi on 01/05/23.
//

import Foundation
import AVFoundation

class MusicPlayerViewModel: ObservableObject {
    var musicPlayerModel = MusicPlayerModel()
    
    var songPlayer: AVAudioPlayer?
    
    func checkIfNewDay() -> String {
        let currentDate: Date = Date()
        let calendar: Calendar = Calendar.current
        
        
        // Check if last date is nil or if last date is the same as current date
        if (musicPlayerModel.lastDate == nil || !calendar.isDate(musicPlayerModel.lastDate!, inSameDayAs: currentDate)) {
            
            musicPlayerModel.lastDate = currentDate
            
            musicPlayerModel.selectedSong = musicPlayerModel.musicList.randomElement()!
            
            return musicPlayerModel.selectedSong
        } else {
            
            return musicPlayerModel.selectedSong
            
        }
    }
    
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
