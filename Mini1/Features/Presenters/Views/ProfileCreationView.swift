//
//  ProfileCreationView.swift
//  Mini1
//
//  Created by Leo Harnadi on 24/04/23.
//

import SwiftUI

struct ProfileCreationView: View {
    @StateObject var EKManager: EventKitManager = EventKitManager()
    
    var body: some View {
        VStack {
            Button("Add reminder") {
                EKManager.addReminder(hour: 9, minute: 0)
            }
            .padding()
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

