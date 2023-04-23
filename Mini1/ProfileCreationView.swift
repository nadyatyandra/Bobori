//
//  ProfileCreationView.swift
//  Mini1
//
//  Created by Leo Harnadi on 24/04/23.
//

import SwiftUI

struct ProfileCreationView: View {
    @StateObject var viewModel: ProfileCreationViewModel = ProfileCreationViewModel()
    
    var body: some View {
        VStack {
            Button("Add reminder") {
                viewModel.addReminder()
            }
            .padding()
        }
        .onAppear(){
            viewModel.requestAccess()
        }
        .alert(isPresented: $viewModel.emptyReminderList) {
            Alert(
                title: Text("No Reminder List Found"),
                message: Text("Please create a list in your Reminders app."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

