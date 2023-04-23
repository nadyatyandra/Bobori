//
//  EditProfileViewModel.swift
//  Mini1
//
//  Created by Nadya Tyandra on 23/04/23.
//

import Foundation
import SwiftUI
import EventKit

class EditProfileViewModel: ObservableObject {
    let eventStore = EKEventStore()

    func editReminder() {
        let predicate: NSPredicate? = eventStore.predicateForReminders(in: nil)
        if let aPredicate = predicate {
            eventStore.fetchReminders(matching: aPredicate, completion: { [self](_ reminders: [Any]?) -> Void in
                for reminder: EKReminder? in reminders as? [EKReminder?] ?? [EKReminder?]() {
                    if reminder?.title == "My Daily Reminder" {
                        do {
                            try eventStore.remove(reminder!, commit: true)
                                // Handle successful deletion
                        } catch {
                            // Handle deletion error
                            print("error")
                        }
                    }
                }
            })
        }
        
    }
}
