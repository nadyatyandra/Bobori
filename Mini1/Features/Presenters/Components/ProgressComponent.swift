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
    @State var isFilled: Bool = false
    
    // Bool to toggle edit profile view
    @State var showProfile: Bool = false
    
    // Music Variables
    @Binding var showMusic: Bool
    @Binding var playMusic: Bool
    var musicPlayerViewModel: MusicPlayerViewModel
    
    // Name Time for reminder
    @Binding var name: String
    @Binding var time: Date
    
    // Progress Bar Variable
    @State var currentStageIndex: Int = 0
    var distances: [String] = ["Besides crib", "Halfway towards door", "Next to doorway", "Outside the room (seen)", "Outside the room (unseen)"]
    
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
                                        .frame(width: 60, height: 7)
                                        .foregroundColor(.white)
                                        .border(Color("paleBlue"))
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
                                
                            Text("Stage \(currentStageIndex + 1): \(distances[currentStageIndex])")
                                    .foregroundColor(.white)
                                                   
                                                   
                                                           
                    
                                                   }
                                               }                    }
                    
                    
                    
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color("terracotta"))
                            .frame(width: 324, height: 57)
                            .shadow(radius: 3)
                            
                            
                            
                        Button(isFilled ? "View Daily Progress" : "➕ Add Daily Progress") {
                            checkDailyProgress()
                            selectedDate = Date()
                            showSheet = true
                        }
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .onAppear {
                            checkDailyProgress()
                        }
                        
                    }
                    .padding(.top)
                    
                    CalendarView(selectedDate: $selectedDate, isFilled: $isFilled, showSheet: $showSheet, entryViewModel: entryViewModel)
                        .padding(.top, -30)
                        .padding(.bottom, -10)
                    
                    //                    Button("Go to information view") {
                    //                        viewModel.navigateToSecondTab()
                    //                    }
                    //                    .padding()
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack{
                    VStack{
                        Text("Progress")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .padding(.leading, -270)
                        
                        Text("Sleep Training")
                            .font(.system(size: 21))
                            .foregroundColor(Color("paleBlue"))
                            .padding(.leading, -270)
                    }
                    Button() {
                        showProfile = true
                    } label: {
                        Image("placeholder")
                            .resizable()
                            .frame(width: 54, height: 54)
                        
                    }
                } .padding(.top, 30)
            }
        }
        .sheet(isPresented: $showProfile) {
            EditProfileView(showProfile: $showProfile, name: $name, time: $time)
        }
        .sheet(isPresented: $showMusic) {
            MusicPlayerView(musicPlayerViewModel: musicPlayerViewModel, showMusic: $showMusic, playMusic: $playMusic, name: $name)
        }
        .sheet(isPresented: $showSheet) {
            if isFilled {
               HistoryView(entryViewModel: self.entryViewModel, entry: entryViewModel.getOneEntry(date: selectedDate)!)
            } else {
                ProgressFormView(entryViewModel: self.entryViewModel, date: $selectedDate, name: $name, showSheet: $showSheet, isFilled: $isFilled, currentStageIndex: $currentStageIndex, distances: distances)
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
    }
}
