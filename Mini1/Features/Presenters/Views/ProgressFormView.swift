//
//  AddEntryView.swift
//  Mini1
//
//  Created by Nadya Tyandra on 02/05/23.
//

import SwiftUI
import LottieUI

struct ProgressFormView: View {
    @ObservedObject var entryViewModel: EntryViewModel
    @State private var bedTime: Date = Date()
    @State private var distance = "Besides crib"
    @Binding var date: Date
    @Binding var name: String
    @Binding var showSheet: Bool
    @Binding var isFilled: Bool
    @Binding var dailyIsFilled: Bool
    @Binding var dailyShowSheet: Bool
    @Binding var formFilled: Bool
    @Binding var currentStageIndex: Int
    @Binding var maxStageIndex: Int
    @State private var currentPageIndex: Int = 0
    
    @Environment(\.presentationMode) var presentationMode
    var distances: [String]
    
    var body: some View {
        NavigationView {
            if currentPageIndex == 0 {
                ZStack{
                    Color("paleBlue").ignoresSafeArea()
                    VStack {
                        LottieView(state: LUStateData(type: .name("empat", .main), loopMode: .loop))
                            .scaleEffect(0.5)
                            .padding(.top, -150)
                        Text("What time did \(name) sleep?")
                            .font(Font.custom("Comfortaa", size: 32))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.top, -275)
                            .frame(width: 304, height: 130)
                        DatePicker("", selection: $bedTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                            .frame(width: 299, height: 210)
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding(.top, -190)
                        
                        Button(action: {
                            withAnimation(){
                                currentPageIndex += 1
                            }
                        }, label: {
                            Text("Next")
                                .frame(width: 210, height: 55)
                                .background(Color.white)
                                .cornerRadius(70)
                                .font(.system(size: 21))
                                .foregroundColor(Color("paleBlue"))
                                .padding(.top, 90)
                                .padding(.bottom, 35)
                                
                        })
                    } .padding(.top, -50)
                        .transition(.opacity)
                }
            } else if currentPageIndex == 1 {
                ZStack{
                    Color("paleBlue").ignoresSafeArea()
                    VStack{
                        LottieView(state: LUStateData(type: .name("empat", .main), loopMode: .loop))
                            .scaleEffect(1.25)
                            .padding(.top, 30)
                        
                        Text("How's today's distance?")
                            .font(Font.custom("Comfortaa", size: 32))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(width: 305, height: 80)
                            .padding(.top, 20)
                            
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .frame(width: 299, height: 210)
                            
                            Picker("Please choose a distance", selection: $distance) {
                                
                                if maxStageIndex < 4 {
                                    ForEach(distances.prefix(maxStageIndex + 2), id: \.self) {
                                        Text($0)
                                            .multilineTextAlignment(.leading)
                                            .font(.system(size: 18))
                                    }
                                } else {
                                    ForEach(distances, id: \.self) {
                                        Text($0)
                                            .multilineTextAlignment(.leading)
                                            .font(.system(size: 18))
                                    }
                                }
                            }
                            .pickerStyle(.wheel)
                            
                        } .padding(.top, 50)

                        
                        Button(action: {
                            let currentDate: Date = Date()
                            let calendar: Calendar = Calendar.current
                            
                            self.entryViewModel.createEntry(date: self.date, bedTime: self.bedTime, distance: self.distance)
                            showSheet = false
                            isFilled = true
                            formFilled.toggle()
                            
                            
                            if dailyShowSheet || calendar.isDate(date, inSameDayAs: currentDate) {
                                dailyIsFilled = true
                            }
                            
                            currentStageIndex = distances.firstIndex(where: { $0 == distance })!
                            
                            if currentStageIndex > maxStageIndex {
                                maxStageIndex = currentStageIndex
                            }
                            
                            entryViewModel.editProgress(entry: entryViewModel.progress[0], currentStageIndex: currentStageIndex, maxStageIndex: maxStageIndex)
                            
                        }) {
                            Text("Save")
                        }
                            .frame(width: 210, height: 55)
                            .background(Color.white)
                            .cornerRadius(70)
                            .font(.system(size: 21))
                            .foregroundColor(Color("paleBlue"))
                            .padding(.top, 90)
                        
                        Button(action: {
                            withAnimation() {
                                currentPageIndex -= 1
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .padding(.top, -700)
                        .padding(.leading, -165)

                    }
                }
            }
        }
    }
}
