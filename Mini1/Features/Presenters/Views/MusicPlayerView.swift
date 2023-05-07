//
//  MusicPlayerView.swift
//  Mini1
//
//  Created by Leo Harnadi on 01/05/23.
//
import SwiftUI
//import LottieUI

struct PausableRotation: GeometryEffect {
  
    // this binding is used to inform the view about the current, system-computed angle value
    @Binding var currentAngle: CGFloat
    private var currentAngleValue: CGFloat = 0.0

    // this tells the system what property should it interpolate and update with the intermediate values it computed
    var animatableData: CGFloat {
        get { currentAngleValue }
        set { currentAngleValue = newValue }
    }

    init(desiredAngle: CGFloat, currentAngle: Binding<CGFloat>) {
        self.currentAngleValue = desiredAngle
        self._currentAngle = currentAngle
    }

    // this is the transform that defines the rotation
    func effectValue(size: CGSize) -> ProjectionTransform {

    // this is the heart of the solution:
    //   reporting the current (system-computed) angle value back to the view
    //
    // thanks to that the view knows the pause position of the animation
    // and where to start when the animation resumes
    //
    // notice that reporting MUST be done in the dispatch main async block to avoid modifying state during view update
    // (because currentAngle is a view state and each change on it will cause the update pass in the SwiftUI)
    DispatchQueue.main.async {
        self.currentAngle = currentAngleValue
    }

    // here I compute the transform itself
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
    
//    //state
//    @State var isRotating: Bool = false
    @State var desiredAngle: CGFloat = 0.0
//    @State var currentAngle: CGFloat = 0.0
    
    //binding
    @Binding var isRotating: Bool
//    @Binding var desiredAngle: CGFloat
    @Binding var currentAngle: CGFloat
    
    var foreverAnimation: Animation {
      Animation.linear(duration: 1.8)
        .repeatForever(autoreverses: false)
    }
    
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
                    
//                    LottieView(state: LUStateData(type: .name("enam", .main), loopMode: .loop))
//                        .scaleEffect(0.8)
                    
                    //text lain ga ke display, cmn image aja yg bs muncul
//                    Image("music disc-12")
//                        .scaleEffect(0.3)
//                    Image("music disc-11")
//                        .scaleEffect(0.3)

                    //placeholder
                    Image("Stage1Card")
                        .modifier(PausableRotation(desiredAngle: desiredAngle, currentAngle: $currentAngle))
                    
                }
                
                Button(playMusic ? "⏹ Stop" : " ▶ Play") {
                    playMusic.toggle()
        
                    if playMusic {
                        musicPlayerViewModel.playSong()
                    } else {
                        musicPlayerViewModel.stopSong()
                    }
                    
                    self.isRotating.toggle()
                    // normalize the angle so that we're not in the tens or hundreds of radians
                    let startAngle = currentAngle.truncatingRemainder(dividingBy: CGFloat.pi * 2)
                    // if rotating, the final value should be one full circle furter
                    // if not rotating, the final value is just the current value
                    let angleDelta = isRotating ? CGFloat.pi * 2 : 0.0
                    withAnimation(isRotating ? foreverAnimation : .linear(duration: 0)) {
                      self.desiredAngle = startAngle + angleDelta
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
