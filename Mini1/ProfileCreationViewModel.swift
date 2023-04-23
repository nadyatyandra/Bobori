//
//  ProfileCreationViewModel.swift
//  Mini1
//
//  Created by Leo Harnadi on 24/04/23.
//

import Foundation
import SwiftUI
import EventKit

class ProfileCreationViewModel: ObservableObject {
    let eventStore = EKEventStore()
    @Published var emptyReminderList: Bool = false
    
    func requestAccess() {
        eventStore.requestAccess(to: .reminder) { (granted, error) in
            if granted {
                print("test")
                
            } else {
                print("Access to reminders not granted")
            }
        }
    }
    
    func addReminder() {
        if eventStore.defaultCalendarForNewReminders() != nil {
            emptyReminderList = false
            
            let reminder = EKReminder(eventStore: eventStore)
            reminder.title = "My Daily Reminder"
            reminder.calendar = eventStore.defaultCalendarForNewReminders()
            
            let recurrenceRule = EKRecurrenceRule(recurrenceWith: .daily, interval: 1, end: nil)
            reminder.addRecurrenceRule(recurrenceRule)
            
            let dueDate = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!
            reminder.dueDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
            
            do {
                try eventStore.save(reminder, commit: true)
                print("Reminder created successfully")
            } catch {
                print("Error creating reminder: \(error.localizedDescription)")
            }
        } else {
            emptyReminderList = true
        }
        
    }
}

