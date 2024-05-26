//
//  TrackedHabitsByDate+CoreDataProperties.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 15.05.2024.
//
//

import Foundation
import CoreData


extension TrackedHabitsByDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackedHabitsByDate> {
        return NSFetchRequest<TrackedHabitsByDate>(entityName: "TrackedHabitsByDate")
    }

    @NSManaged public var date: Date
    @NSManaged public var doneHabits: [String]?
    @NSManaged public var allHabits: [String]?

}

extension TrackedHabitsByDate : Identifiable {

}
