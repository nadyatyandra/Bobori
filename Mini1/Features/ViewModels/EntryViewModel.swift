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
    @Published var selectedDateEntry: [SleepRoutine] = []
//    @Published var child: [Child] = []
//    @Published var music: [Music] = []
    
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
    
    func getOneEntry(date: Date) -> SleepRoutine? {
        let context = CoreDataManager.shared.mainContext
        let fetchRequest: NSFetchRequest<SleepRoutine> = SleepRoutine.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", "\(date.formatted(date: .abbreviated, time: .omitted))")
        
        do {
            let object = try context.fetch(fetchRequest).first
            return object
        } catch {
            return nil
        }
    }
    
    func createEntry(date: Date, bedTime: Date, distance: String) {
        let item = SleepRoutine(bedTime: bedTime, date: date.formatted(date: .abbreviated, time: .omitted), distance: distance)
        entries.append(item)
        saveToPersistentStore()
    }
}
