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
    
    // For Calendar
    @State var selectedDate = Date()
    
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
                                    Rectangle()
                                    .frame(width: 10, height: 5)
                                }
                             
                            if currentStageIndex < 4 {
                                ForEach((0...(3-currentStageIndex)), id: \.self) {_ in
                                        Circle()
                                        .frame(width: 10, height: 5)
                                    }
                            }
                        }
                        
                        Text("Stage \(currentStageIndex + 1): \(distances[currentStageIndex])")
                    }
                    
                    
                    
                    
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color("terracotta"))
                            .frame(width: 324, height: 57)
                            .shadow(radius: 3)
                            
                            
                            
                        Button(viewModel.isFilled ? "View Daily Progress" : "➕ Add Daily Progress") {
                            viewModel.checkDailyProgress()
                            selectedDate = Date()
                            viewModel.showSheet = true
                        }
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .onAppear {
                            viewModel.checkDailyProgress()
                        }
                        
                    }
                    .padding(.top, 130)
                    
                    CalendarView(selectedDate: $selectedDate, isFilled: $viewModel.isFilled, showSheet: $viewModel.showSheet, entryViewModel: viewModel.entryViewModel)
                        .padding(.top, -20)
                    
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
        .sheet(isPresented: $viewModel.showSheet) {
            if viewModel.isFilled {
               HistoryView(entryViewModel: self.viewModel.entryViewModel, entry: viewModel.entryViewModel.getOneEntry(date: selectedDate)!)
            } else {
                ProgressFormView(entryViewModel: self.viewModel.entryViewModel, date: $selectedDate, name: $name, showSheet: $viewModel.showSheet, isFilled: $viewModel.isFilled, currentStageIndex: $currentStageIndex, distances: distances)
            }
        }
    }
}
