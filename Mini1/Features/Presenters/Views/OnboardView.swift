//
//  OnboardView.swift
//  Mini1
//
//  Created by Leo Harnadi on 29/04/23.
//

import SwiftUI

struct OnboardView: View {
    @Binding var isOnboardingCompleted: Bool
    @State private var currentPageIndex: Int = 0
    
    @Binding var name: String
    @Binding var time: Date
    
    @StateObject var EKManager: EventKitManager = EventKitManager()
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                if currentPageIndex == 0 {
                    Form1View(name: $name)
                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
                } else if currentPageIndex == 1 {
                    Form2View(time: $time, name: $name)
                        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                } else {
                    Form3View()
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
                }
                
                
                Spacer()
                
                HStack {
                    if currentPageIndex > 0 {
                        Button("back") {
                            withAnimation() {
                                currentPageIndex -= 1
                            }
                            
                        }
                        .padding()
                    }
                    
                    Spacer()
                    
                    if currentPageIndex < 2 {
                        Button("next") {
                            withAnimation() {
                                currentPageIndex += 1
                            }
                            
                        }
                        .padding()
                        .disabled(name.isEmpty)
                    } else {
                        Button("proceed") {
                            withAnimation() {
                                EKManager.addReminder(hour: Calendar.current.component(.hour, from: time), minute: Calendar.current.component(.minute, from: time))
                                
                                isOnboardingCompleted = true
                            }
                            
                        }
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
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Pls enter ur lil one's name")) {
                    TextField("Name", text: $name)
                }
                
            }
            .navigationBarTitle("Welcome")
        }
        
    }
}

struct Form2View: View {
    @Binding var time: Date
    @Binding var name: String
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("What time does \(name) sleep")) {
                    DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
            }
            .navigationBarTitle("Page 2")
        }

    }
}

struct Form3View: View {
    var body: some View {
        NavigationView {
            Text("Youre all set!")
        }
        
    }
}
