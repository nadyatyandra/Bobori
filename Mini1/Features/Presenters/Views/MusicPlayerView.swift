//
//  MusicPlayerView.swift
//  Mini1
//
//  Created by Leo Harnadi on 01/05/23.
//
import SwiftUI

struct PausableRotation: GeometryEffect {
    @Binding var currentAngle: CGFloat
    private var currentAngleValue: CGFloat = 0.0
    
    var animatableData: CGFloat {
        get { currentAngleValue }
        set { currentAngleValue = newValue }
    }
    
    init(desiredAngle: CGFloat, currentAngle: Binding<CGFloat>) {
        self.currentAngleValue = desiredAngle
        self._currentAngle = currentAngle
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        
        DispatchQueue.main.async {
            self.currentAngle = currentAngleValue
        }
        
        let xOffset = size.width / 2
        let yOffset = size.height / 2
        let transform = CGAffineTransform(translationX: xOffset, y: yOffset)
            .rotated(by: currentAngleValue)
            .translatedBy(x: -xOffset, y: -yOffset)
        return ProjectionTransform(transform)
    }
}

struct MusicPlayerView: View {
    @ObservedObject var musicPlayerViewModel: MusicPlayerViewModel
    @ObservedObject var entryViewModel: EntryViewModel
    
    @Binding var showMusic: Bool
    @Binding var chosenMusic: String
    @Binding var lastDate: Date
    
    @Binding var playMusic: Bool
    @Binding var name: String
    
    @State var desiredAngle: CGFloat = 0.0
    @Binding var isRotating: Bool
    @Binding var currentAngle: CGFloat
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 1.8)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
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
                    Image("music disc-12")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 300)
                        .modifier(PausableRotation(desiredAngle: desiredAngle, currentAngle: $currentAngle))
                    Image("music disc-11")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 300)
                }
                .onAppear() {
                    if playMusic == true {
                        isRotating = false
                        playAnim()
                        isRotating = true
                        playAnim()
                    }
                }
                
                Button(playMusic ? "⏹ Stop" : " ▶ Play") {
                    playMusic.toggle()
                    
                    if playMusic {
                        musicPlayerViewModel.playSong()
                    } else {
                        musicPlayerViewModel.stopSong()
                    }
                    
                    self.isRotating.toggle()
                    playAnim()
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
    
    func playAnim() {
        let startAngle = currentAngle.truncatingRemainder(dividingBy: CGFloat.pi * 2)
        let angleDelta = isRotating ? CGFloat.pi * 2 : 0.0
        withAnimation(isRotating ? foreverAnimation : .linear(duration: 0)) {
            self.desiredAngle = startAngle + angleDelta
        }
    }
}
