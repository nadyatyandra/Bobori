//
//  EntryViewModel.swift
//  Mini1
//
//  Created by Nadya Tyandra on 02/05/23.
//

import Foundation
import CoreData
import Combine

class EntryViewModel: ObservableObject {
    @Published var entries: [SleepRoutine] = []
    
    init() {
        getEntries()
    }
    
    func saveToPersistentStore() {
        let moc = CoreDataManager.shared.mainContext
        do {
            try moc.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
    
    func getEntries() {
        let fetchRequest: NSFetchRequest<SleepRoutine> = SleepRoutine.fetchRequest()
        let moc = CoreDataManager.shared.mainContext
        
        do {
            entries = try moc.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching tasks: \(error)")
        }
    }
    
    func createEntry(date: Date, bedTime: Date, distance: String) {
        let item = SleepRoutine(bedTime: bedTime, date: date, distance: distance)
        entries.append(item)
        saveToPersistentStore()
    }
}
