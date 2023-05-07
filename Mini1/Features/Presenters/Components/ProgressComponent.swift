//
//  CalendarView.swift
//  Mini1
//
//  Created by Leo Harnadi on 23/04/23.
//

import SwiftUI
import EventKit

struct ProgressComponent: View {
    @ObservedObject var viewModel: ProgressViewModel
    @ObservedObject var entryViewModel: EntryViewModel
    
    // For Calendar
    @State var selectedDate = Date()
    @State var showSheet: Bool = false
    @State var dailyShowSheet: Bool = false
    @State var isFilled: Bool = false
    @State var dailyIsFilled: Bool = false
    @State var formFilled: Bool = false
    
    // Bool to toggle edit profile view
    @State var showProfile: Bool = false
    
    // Music Variables
    @Binding var showMusic: Bool
    @Binding var playMusic: Bool
    @ObservedObject var musicPlayerViewModel: MusicPlayerViewModel
    
    // Name Time for reminder
    @Binding var name: String
    @Binding var time: Date
    
    // Progress Bar Variable
    @State var currentStageIndex: Int = 0
    @State var maxStageIndex: Int = 0
    var distances: [String] = ["Besides crib", "Halfway towards door", "Next to doorway", "Outside the room (seen)", "Outside the room (unseen)"]
    
    // For Music
    @Binding var chosenMusic: String
    @Binding var lastDate: Date
    
    //binding
    @Binding var isRotating: Bool
//    @Binding var desiredAngle: CGFloat
    @Binding var currentAngle: CGFloat
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        ForEach((0...currentStageIndex), id: \.self) {_ in
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 60, height: 7)
                                .foregroundColor(Color("paleBlue"))
                                .padding(.top, -50)
                        }

                        if currentStageIndex < 4 {
                            ForEach((0...(3-currentStageIndex)), id: \.self) {_ in
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color("paleBlue"), lineWidth: 1)
                                    .frame(width: 60, height: 7)
                                    .padding(.top, -50)
                            }
                        }
                    }
                    
                    ZStack{
                                               
                        RoundedRectangle(cornerRadius: 12)
                                .frame(width: 324, height: 144)
                                .foregroundColor(Color("paleBlue"))
                                .padding(.top, -30)

                       
                                
                                               
                        VStack{
                            Text("\(name) is currently at")
                                .font(Font.custom("Nunito ExtraLight", size: 16))
                                .foregroundColor(.white)
                                .padding(.top, -60)
                                .padding(.leading, -140)
                                
                            Text("Stage \(currentStageIndex + 1)")
                                .font(Font.custom("Nunito ExtraLight", size: 21))
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding(.top, -50)
                                        .padding(.leading, -140)
                        }
                        
                        if(currentStageIndex == 0){
                            Image("Stage1Card")
                                .resizable()
                                .frame(width: 284, height: 74)
                                .padding(.top, 20)
                        } else if(currentStageIndex == 1){
                            Image("Stage2Card")
                                .resizable()
                                .frame(width: 284, height: 74)
                                .padding(.top, 20)
                        } else if(currentStageIndex == 2){
                            Image("Stage3Card")
                                .resizable()
                                .frame(width: 284, height: 74)
                                .padding(.top, 20)
                        } else if(currentStageIndex == 3){
                            Image("Stage4Card")
                                .resizable()
                                .frame(width: 81, height: 75)
                                .padding(.top, 20)
                                .padding(.leading, 200)
                        } else if(currentStageIndex == 4){
                            Image("Stage5Card")
                                .resizable()
                                .frame(width: 81, height: 75)
                                .padding(.top, 20)
                                .padding(.leading, 200)
                        }
                    }
                }

                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color("terracotta"))
                        .frame(width: 324, height: 57)
                        .shadow(radius: 3)
                    Button(dailyIsFilled ? "View Daily Progress" : "➕ Add Daily Progress") {
                        checkDailyProgress()
                        selectedDate = Date()
                        showSheet = true
                        dailyShowSheet = true
                    }
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .onAppear {
                        checkDailyProgress()
                    }
                    
                }
                .padding(.top)
                
                CalendarView(selectedDate: $selectedDate, isFilled: $isFilled, showSheet: $showSheet, formFilled: $formFilled, entryViewModel: entryViewModel)
                    .padding(.top, -30)
                    .padding(.bottom, -10)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color("mustard"))
                        .frame(width: 324, height: 57)
                        .shadow(radius: 3)
                        
                    Button("Music Recommendation") {
                        showMusic = true
                    } .font(.system(size: 16))
                        .foregroundColor(.white)
                    
                } .padding(.bottom, 30)
            }
        }
        .onAppear() {
            currentStageIndex = Int(entryViewModel.progress[0].currentStageIndex)
            maxStageIndex = Int(entryViewModel.progress[0].maxStageIndex)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack{
                    VStack{
                        Text("Progress")
                            .font(Font.custom("Comfortaa", size: 16))
                            .foregroundColor(.gray)
                            .padding(.leading, -270)
                            .fontWeight(.semibold)
                        
                        Text("Sleep Training")
                            .font(Font.custom("Comfortaa", size: 21))
                            .foregroundColor(Color("paleBlue"))
                            .padding(.leading, -270)
                    
                    }
                    Button() {
                        showProfile = true
                    } label: {
                        Image("ProfilePicture")
                            .resizable()
                            .frame(width: 54, height: 54)
                            .padding(.trailing, 10)
                        
                    }
                } .padding(.top, 30)
            }
        }
        .sheet(isPresented: $showProfile) {
            EditProfileView(showProfile: $showProfile, oldName: name, newName: $name, time: $time, entryViewModel: entryViewModel)
        }
        .sheet(isPresented: $showMusic) {
            //ori
//            MusicPlayerView(musicPlayerViewModel: musicPlayerViewModel, entryViewModel: entryViewModel, showMusic: $showMusic, chosenMusic: $chosenMusic, lastDate: $lastDate, playMusic: $playMusic, name: $name)
            
            //binding 2
            MusicPlayerView(musicPlayerViewModel: musicPlayerViewModel, entryViewModel: entryViewModel, showMusic: $showMusic, chosenMusic: $chosenMusic, lastDate: $lastDate, playMusic: $playMusic, name: $name, isRotating: $isRotating, currentAngle: $currentAngle)
            
            //binding 3
//            MusicPlayerView(musicPlayerViewModel: musicPlayerViewModel, entryViewModel: entryViewModel, showMusic: $showMusic, chosenMusic: $chosenMusic, lastDate: $lastDate, playMusic: $playMusic, name: $name, isRotating: $isRotating, desiredAngle: $desiredAngle, currentAngle: $currentAngle)
        }
        .sheet(isPresented: $showSheet) {
            if isFilled {
               HistoryView(entryViewModel: self.entryViewModel, entry: entryViewModel.getOneEntry(date: selectedDate)!)
            } else {
                ProgressFormView(entryViewModel: self.entryViewModel, date: $selectedDate, name: $name, showSheet: $showSheet, isFilled: $isFilled, dailyIsFilled: $dailyIsFilled, dailyShowSheet: $dailyShowSheet, formFilled: $formFilled, currentStageIndex: $currentStageIndex, maxStageIndex: $maxStageIndex, distances: distances)
                    .onDisappear {
                        dailyShowSheet = false
                }
            }
        }
    }
    
    func checkDailyProgress() {
        let date = Date()
        entryViewModel.selectedDateEntry.removeAll()
        
        guard let sleepRoutine = entryViewModel.getOneEntry(date: date)
        else {
            isFilled = false
            return
        }
        entryViewModel.selectedDateEntry.append(sleepRoutine)
        isFilled = true
        dailyIsFilled = true
        dailyShowSheet = false
    }
}
