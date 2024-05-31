//
//  Record+CoreDataProperties.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 31.05.2024.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var date: Date?
    @NSManaged public var doneHabits: NSObject?

}

extension Record : Identifiable {

}
