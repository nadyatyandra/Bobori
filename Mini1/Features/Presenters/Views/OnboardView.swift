//
//  OnboardView.swift
//  Mini1
//
//  Created by Leo Harnadi on 29/04/23.
//

import SwiftUI
import LottieUI

struct OnboardView: View {
    @State private var currentPageIndex: Int = 0
    @Binding var name: String
    @Binding var time: Date
    @ObservedObject var entryViewModel: EntryViewModel
    
    @StateObject var EKManager: EventKitManager = EventKitManager()
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    @Binding var isOnboardingCompleted: Bool
    
    let paleBlue = Color(UIColor(named: "paleBlue")!)
    
    var body: some View {
        ZStack {
            Color("paleBlue")
            
            VStack {
                if currentPageIndex == 0 {
                    HelloScreenView()
                } else if currentPageIndex == 1 {
                    Form1View(name: $name)
                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
                } else if currentPageIndex == 2 {
                    Form2View(time: $time, name: $name)
                        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                }
                
                Spacer()
                
                HStack {
                    if currentPageIndex == 0 {
                        HStack {
                            Button(action: {
                                withAnimation() {
                                    currentPageIndex += 1
                                }
                            }, label: {
                                Text("Continue")
                                    .font(.system(size: 21))
                                    .foregroundColor(Color("paleBlue"))
                                    .frame(width: 210, height: 55)
                                    .background(Color.white)
                                    .cornerRadius(70)
                                    .padding(.leading, 5)
                                    .padding(.bottom, 50)
                                    .background(Color("paleBlue"))
                            })
                        }
                    }
                    
                    if currentPageIndex == 1 {
                        HStack {
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
                            .padding(.leading, 30)
                            Spacer()
                        }
                        HStack {
                            Button(action: {
                                withAnimation() {
                                    currentPageIndex += 1
                                }
                            }, label: {
                                Text("Continue")
                                    .font(.system(size: 21))
                                    .foregroundColor(profileViewModel.nameIsEmpty(name: name) ? Color.white : Color("paleBlue"))
                                    .frame(width: 210, height: 55)
                                    .background(profileViewModel.nameIsEmpty(name: name) ? Color.gray : Color.white)
                                    .cornerRadius(70)
                                    .padding(.trailing, 90)
                                    .padding(.bottom, 50)
                                    .background(Color("paleBlue"))
                            })
                            .disabled(profileViewModel.nameIsEmpty(name: name))
                        }
                    }
                    
                    if currentPageIndex == 2 {
                        HStack {
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
                            .padding(.leading, 30)
                            Spacer()
                        }
                            Spacer()
                            HStack {
                                Button(action: {
                                    withAnimation() {
                                        EKManager.addReminder(name: name, hour: Calendar.current.component(.hour, from: time), minute: Calendar.current.component(.minute, from: time))

                                        if !EKManager.emptyReminderList {
                                            entryViewModel.saveToChild(entry: entryViewModel.child[0], name: name, bedTime: time)
                                            entryViewModel.completeOnboarding(entry: entryViewModel.progress[0])

                                            isOnboardingCompleted = true
                                        }
                                    }
                                }, label: {
                                    Text("Save")
                                        .font(.system(size: 21))
                                        .foregroundColor(Color("paleBlue"))
                                        .frame(width: 210, height: 55)
                                        .background(Color.white)
                                        .cornerRadius(70)
                                        .padding(.bottom, 33)
                                        .padding(.trailing, 75)
                                })
                                .padding()
                            }
                        }
                    }
                }
            }
        .onAppear(){
            EKManager.requestAccess()
        }
        .alert(isPresented: $EKManager.emptyReminderList) {
            Alert(
                title: Text("No Reminder List Found"),
                message: Text("Please create a list in your Reminders app."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct HelloScreenView: View {
    let paleBlue = Color(UIColor(named: "paleBlue")!)
    
    var body: some View {
        ZStack {
            Color("paleBlue").ignoresSafeArea()
            
            VStack {
                LottieView(state: LUStateData(type: .name("satu", .main), loopMode: .loop))
                    .scaleEffect(0.7)
                Text("Hello, I'm Bori")
                    .font(Font.custom("Comfortaa", size: 32))
                    .foregroundColor(.white)
                    .frame(width: 132, height: 120)
                    .padding(.top, -380)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                Text("Your new sleep assistant to track your baby's sleep")
                    .font(Font.custom("Nunito ExtraLight", size: 21))
                    .foregroundColor(.white)
                    .frame(width: 258, height: 150)
                    .multilineTextAlignment(.center)
                    .padding(.top, -320)
                
            } .padding(.top, -300)
        }
    }
}

struct Form1View: View {
    @Binding var name: String
    @State private var showForm2View = false
    let paleBlue = Color(UIColor(named: "paleBlue")!)
    
    var body: some View {
        ZStack {
            paleBlue.edgesIgnoringSafeArea(.all)
            VStack{
                LottieView(state: LUStateData(type: .name("dua", .main), loopMode: .loop))
                    .scaleEffect(0.7)
                    .padding(.top, -100)
                Text("Welcome!")
                    .font(Font.custom("Comfortaa", size: 32))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.top, -100)
                    .padding(.bottom, 50)
                Text("What's the name of your little one?")
                    .font(Font.custom("Nunito ExtraLight", size: 21))
                    .frame(width: 177, height: 80)
                    .padding(.top, -100)
                    .padding(.bottom, 35)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 305, height: 45)
                    .overlay(
                        TextField("Your Baby's Name", text: $name)
                            .font(Font.custom("Nunito ExtraLight", size: 18))
                            .padding()
                    )
                    .padding(.bottom, 170)
            }
        }
    }
}

struct Form2View: View {
    @Binding var time: Date
    @Binding var name: String
    
    let paleBlue = Color(UIColor(named: "paleBlue")!)
    
    var body: some View {
        ZStack{
            paleBlue.edgesIgnoringSafeArea(.all)
            VStack {
                LottieView(state: LUStateData(type: .name("tiga", .main), loopMode: .loop))
                    .scaleEffect(1)
                Text("Nice to know \(name)!")
                    .font(Font.custom("Nunito ExtraLight", size: 24))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Text("What's your little one's sleeping time?")
                    .font(Font.custom("Nunito ExtraLight", size: 21))
                    .multilineTextAlignment(.center)
                    .frame(width: 260, height: 150)
                    .padding(.top, -50)
                    .padding(.bottom, 45)
                    .foregroundColor(.white)
                ZStack {
                    Color("paleBlue")
                    DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .frame(width: 299, height: 210)
                        .background(Color.white)
                    .cornerRadius(20)
                }
                .padding(.top, -100)
            } .transition(.move(edge: .leading))
        }
    }
}
