//
//  TrackedHabitsByDate+CoreDataProperties.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 12.05.2024.
//
//

import Foundation
import CoreData


extension TrackedHabitsByDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackedHabitsByDate> {
        return NSFetchRequest<TrackedHabitsByDate>(entityName: "TrackedHabitsByDate")
    }

    @NSManaged public var id: UUID
    @NSManaged public var date: Date
    @NSManaged public var doneHabits: NSData?
    @NSManaged public var notDoneHabits: NSData?

}

extension TrackedHabitsByDate : Identifiable {

}
