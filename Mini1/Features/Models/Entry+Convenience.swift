//
//  Entry+Convenience.swift
//  Mini1
//
//  Created by Nadya Tyandra on 02/05/23.
//

import Foundation
import CoreData

extension Child {
    @discardableResult convenience init(name: String, bedTime: Date, context: NSManagedObjectContext = CoreDataManager.shared.mainContext) {
        self.init(context: context)
        self.name = name
        self.bedTime = bedTime
    }
}

extension Music {
    @discardableResult convenience init(selectedSong: String, lastDate: Date, context: NSManagedObjectContext = CoreDataManager.shared.mainContext) {
        self.init(context: context)
        self.selectedSong = selectedSong
        self.lastDate = lastDate
    }
}

extension Progress {
    @discardableResult convenience init(currentStageIndex: Int16, maxStageIndex: Int16, onboardingCompleted: Bool, context: NSManagedObjectContext = CoreDataManager.shared.mainContext) {
        self.init(context: context)
        self.currentStageIndex = currentStageIndex
        self.maxStageIndex = maxStageIndex
        self.onboardingCompleted = onboardingCompleted
    }
}

extension SleepRoutine {
    @discardableResult convenience init(bedTime: Date, date: String, id: UUID = UUID(), distance: String, context: NSManagedObjectContext = CoreDataManager.shared.mainContext) {
        self.init(context: context)
        self.id = id
        self.date = date
        self.bedTime = bedTime
        self.distance = distance
    }
}

extension FilledDate {
    @discardableResult convenience init(date: Date, context: NSManagedObjectContext = CoreDataManager.shared.mainContext) {
        self.init(context: context)
        self.date = date
    }
}
