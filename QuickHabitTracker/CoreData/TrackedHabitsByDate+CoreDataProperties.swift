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

    @NSManaged public var date: Date?
    @NSManaged public var doneHabits: NSArray?
    @NSManaged public var allHabits: NSArray?

}

extension TrackedHabitsByDate : Identifiable {

}
