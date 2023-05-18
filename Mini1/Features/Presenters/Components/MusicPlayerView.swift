//
//  MusicPlayerView.swift
//  Mini1
//
//  Created by Leo Harnadi on 01/05/23.
//

import SwiftUI

struct MusicPlayerView: View {
    @ObservedObject var musicPlayerViewModel: MusicPlayerViewModel
    
    @Binding var showMusic: Bool
    @State var chosenMusic: String = "Song 1" //default music
    
    @Binding var playMusic: Bool
    
    var body: some View {
        // [Song Image]
        Image(chosenMusic)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 100)
        
        // [Song Title]
        Text(chosenMusic)
            .padding()
            .onAppear() {
                chosenMusic = musicPlayerViewModel.checkIfNewDay()
            }
        
        // [Play Button]
        Button(playMusic ? "Stop Music" : "Play Music") {
            playMusic.toggle()
            
            if playMusic {
                musicPlayerViewModel.playSong()
            } else {
                musicPlayerViewModel.stopSong()
            }
        }
        
        // [Close Music Player]
        Button("Close music") {
            showMusic = false
        }
        .padding()
    }
}
