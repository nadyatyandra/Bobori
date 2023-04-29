//
//  EditProfileView.swift
//  Mini1
//
//  Created by Nadya Tyandra on 23/04/23.
//

import SwiftUI

struct EditProfileView: View {
    @StateObject var EKManager: EventKitManager = EventKitManager()
    
    @Binding var showProfile: Bool
    
    @Binding var name: String
    @Binding var time: Date
    
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "person.circle")
                    .font(.system(size: 80))
                    .padding()
                
                Form {
                    
                    Section(header: Text("Name")) {
                        TextField("Name", text: $name)
                    }
                    
                    Section(header: Text("Sleeping Time")) {
                        DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                    
                }
                .navigationBarTitle("Edit Profile")
                
                Spacer()
                
                Button("Edit Reminder") {
                    EKManager.editReminder(hour: Calendar.current.component(.hour, from: time), minute: Calendar.current.component(.minute, from: time))
                    
                    showProfile = false
                }
            }
        }
    }
}
