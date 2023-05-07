//
//  MusicPlayerView.swift
//  Mini1
//
//  Created by Leo Harnadi on 01/05/23.
//
import SwiftUI
import LottieUI

struct MusicPlayerView: View {
    @ObservedObject var musicPlayerViewModel: MusicPlayerViewModel
    @ObservedObject var entryViewModel: EntryViewModel
    
    @Binding var showMusic: Bool
    @Binding var chosenMusic: String
    @Binding var lastDate: Date
    
    @Binding var playMusic: Bool
    @Binding var name: String
    
    var body: some View {
        // [Song Image]
        ZStack{
            Color("paleBlue").ignoresSafeArea()
            VStack{
                Text("Here's a music recommendation for \(name)")
                    .font(Font.custom("Nunito ExtraLight", size: 24))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.white)
                    .onAppear() {
                        chosenMusic = checkIfNewDay().selectedSong
                        lastDate = checkIfNewDay().lastDate ?? Date()
                        entryViewModel.changeMusic(entry: entryViewModel.music[0], lastDate: lastDate, selectedSong: chosenMusic)
                    }
                    .padding(.top, 130)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 22)
                        .frame(width: 291, height: 291)
                        .foregroundColor(.white)
                    
                    LottieView(state: LUStateData(type: .name("enam", .main), loopMode: .loop))
                        .scaleEffect(0.8)
                }
                
                Button(playMusic ? "⏹ Stop" : " ▶ Play") {
                    playMusic.toggle()
        
                    if playMusic {
                        musicPlayerViewModel.playSong()
                    } else {
                        musicPlayerViewModel.stopSong()
                    }
                }
                .frame(width: 210, height: 55)
                .foregroundColor(Color("paleBlue"))
                .font(Font.custom("Nunito ExtraLight", size: 21))
                .background(Color.white)
                .cornerRadius(50)
                .padding(.top, 50)
            }
        }
    }
    
    func checkIfNewDay() -> MusicPlayerModel {
        let currentDate: Date = Date()
        let calendar: Calendar = Calendar.current
        
        
        // Check if last date is nil or if last date is the same as current date
        if (!calendar.isDate(lastDate, inSameDayAs: currentDate)) {
            
            musicPlayerViewModel.musicPlayerModel.lastDate = currentDate
            
            musicPlayerViewModel.musicPlayerModel.selectedSong = musicPlayerViewModel.musicPlayerModel.musicList.randomElement()!
            
            return musicPlayerViewModel.musicPlayerModel
        } else {
            musicPlayerViewModel.musicPlayerModel.lastDate = lastDate
            
            musicPlayerViewModel.musicPlayerModel.selectedSong = chosenMusic
            
            return musicPlayerViewModel.musicPlayerModel
        }
    }
    
}
