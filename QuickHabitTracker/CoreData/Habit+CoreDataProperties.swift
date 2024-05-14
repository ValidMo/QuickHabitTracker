//
//  Habit+CoreDataProperties.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 12.05.2024.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }
    
  

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var isRepeatedOnSun: Bool
    @NSManaged public var isRepeatedOnMon: Bool
    @NSManaged public var isRepeatedOnTue: Bool
    @NSManaged public var isRepeatedOnWed: Bool
    @NSManaged public var isRepeatedOnThu: Bool
    @NSManaged public var isRepeatedOnFri: Bool
    @NSManaged public var isRepeatedOnSat: Bool

}

extension Habit : Identifiable {

}
