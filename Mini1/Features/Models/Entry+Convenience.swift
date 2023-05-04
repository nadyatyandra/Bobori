//
//  Entry+Convenience.swift
//  Mini1
//
//  Created by Nadya Tyandra on 02/05/23.
//

import Foundation
import CoreData

extension SleepRoutine {
    @discardableResult convenience init(bedTime: Date, date: String, id: UUID = UUID(), distance: String, context: NSManagedObjectContext = CoreDataManager.shared.mainContext) {
        self.init(context: context)
        self.id = id
        self.date = date
        self.bedTime = bedTime
        self.distance = distance
    }
}
