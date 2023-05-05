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
    @Binding var name: String
    
    var body: some View {
        // [Song Image]
        ZStack{
            Color("paleBlue").ignoresSafeArea()
            VStack{
                Text("Here's a music recommendation for \(name)")
                    .font(.system(size: 24))
                    .multilineTextAlignment(.center)
                    
                Image(chosenMusic)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 315, height: 315)
                    .padding(.top, 50)
                
                Button(playMusic ? "■ Stop" : " ▶ Play") {
                    playMusic.toggle()
        
                    if playMusic {
                        musicPlayerViewModel.playSong()
                    } else {
                        musicPlayerViewModel.stopSong()
                    }
                }
                .frame(width: 210, height: 55)
                .background(Color.white)
                .cornerRadius(50)
                .padding(.top, 50)
                

               
            }
        }
    }
}
