//
//  EditProfileView.swift
//  Mini1
//
//  Created by Nadya Tyandra on 23/04/23.
//

import SwiftUI

struct EditProfileView: View {
    @StateObject var EKManager: EventKitManager = EventKitManager()
    
    var body: some View {
        Button("Edit Reminder") {
            EKManager.editReminder()
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
