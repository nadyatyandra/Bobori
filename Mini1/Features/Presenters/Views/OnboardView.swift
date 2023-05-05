//
//  OnboardView.swift
//  Mini1
//
//  Created by Leo Harnadi on 29/04/23.
//

import SwiftUI

struct OnboardView: View {
    @State private var currentPageIndex: Int = 0
    @Binding var isOnboardingCompleted: Bool
    @Binding var name: String
    @Binding var time: Date
    @StateObject var EKManager: EventKitManager = EventKitManager()
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    let paleBlue = Color(UIColor(named: "paleBlue")!)
    
    var body: some View {
        ZStack {
            Color("paleBlue")
            
            VStack {
                if currentPageIndex == 0 {
                    Form1View(name: $name)
                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
                } else if currentPageIndex == 1 {
                    Form2View(time: $time, name: $name)
                        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                }
                
                Spacer()
                
                HStack {
                    if currentPageIndex > 0 {
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
                    }

                    Spacer()
                    
                    if currentPageIndex < 1 {
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
                                .background(Color("paleBlue"))
                        })
                        .disabled(profileViewModel.nameIsEmpty(name: name))
                    } else {
                        Button(action: {
                            withAnimation() {
                                EKManager.addReminder(hour: Calendar.current.component(.hour, from: time), minute: Calendar.current.component(.minute, from: time))
                                
                                if !EKManager.emptyReminderList {
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
                            .padding(.bottom, 13)
                            .padding(.trailing, 75)
                        })
                        .padding()
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

struct Form1View: View {
    @Binding var name: String
    @State private var showForm2View = false
    let paleBlue = Color(UIColor(named: "paleBlue")!)
    
    var body: some View {
        ZStack{
            paleBlue.edgesIgnoringSafeArea(.all)
            VStack{
                Image("placeholder")
                    .resizable()
                    .frame(width: 112, height: 112)
                    .padding(.top)
                Text("Welcome!")
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                    .padding(.top)
                Text("What's the name of your little one?")
                    .frame(width: 177, height: 55)
                    .font(.system(size: 21))
                    .padding(.top, 30)
                    .padding(.bottom, 65)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 305, height: 45)
                    .overlay(
                        TextField("Your Baby's Name", text: $name)
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                            .padding()
                    )
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
                Image("placeholder")
                    .resizable()
                    .frame(width: 112, height: 112)
                    .padding(.top, 30)
                Text("Welcome!")
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                    .padding(.top)
                if name.isEmpty {
                    Text("What time does your baby sleep?")
                        .multilineTextAlignment(.center)
                        .frame(width: 300, height: 100)
                        .font(.system(size: 21))
                        .padding(.top, 20)
                        .padding(.bottom, 65)
                        .foregroundColor(.white)
                } else {
                    Text("What time does \(name) sleep?")
                        .multilineTextAlignment(.center)
                        .frame(width: 260, height: 150)
                        .font(.system(size: 21))
                        .padding(.top, -20)
                        .padding(.bottom, 45)
                        .foregroundColor(.white)
                }
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
            }
        }
    }
}
