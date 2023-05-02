//
//  CoreDataManager.swift
//  Mini1
//
//  Created by Nadya Tyandra on 29/04/23.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init(){}
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SleepRoutine")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        return container
    }()
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
}
