//
//  EditProfileView.swift
//  Mini1
//
//  Created by Nadya Tyandra on 23/04/23.
//

import SwiftUI

struct EditProfileView: View {
    @StateObject var viewModel: ReminderViewModel = ReminderViewModel()
    
    var body: some View {
        Button("Edit Reminder") {
            viewModel.editReminder()
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
