//
//  DayRecord+CoreDataProperties.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 27.05.2024.
//
//

import Foundation
import CoreData


extension DayRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayRecord> {
        return NSFetchRequest<DayRecord>(entityName: "DayRecord")
    }

    @NSManaged public var date: Date
    @NSManaged public var allHabits: [String]?
    @NSManaged public var doneHabits: [String]?

}

extension DayRecord : Identifiable {

}
