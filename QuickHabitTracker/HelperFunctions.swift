//
//  HelperFunctions.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 16.05.2024.
//

import Foundation
import CoreData

func whichDayOfWeek(day: Int, month: Int, year: Int) -> String? {
    // Create a Calendar instance
    let calendar = Calendar.current
    
    // Create DateComponents from the provided day, month, and year
    var dateComponents = DateComponents()
    dateComponents.year = year
    dateComponents.month = month
    dateComponents.day = day
    
    // Get the Date object from the DateComponents
    
    guard let date = calendar.date(from: dateComponents) else {
        return nil // Return nil if the date is invalid
    }
    
    
    // Get the weekday from the Date object
    let weekday = calendar.component(.weekday, from: date)
    
    // Map the weekday to its corresponding string representation
    switch weekday {
    case 1:
        return "Sun"
    case 2:
        return "Mon"
    case 3:
        return "Tue"
    case 4:
        return "Wed"
    case 5:
        return "Thu"
    case 6:
        return "Fri"
    case 7:
        return "Sat"
    default:
        return nil // Should never happen, but return nil to handle unexpected cases
    }
}

func AddRecord(day: Int, month: Int, year: Int, context: NSManagedObjectContext, habits: [Habit]) {
    let dayRecord = TrackedHabitsByDate(context: context)
    
    let calendar = Calendar.current
    var dateComponents = DateComponents()
    dateComponents.day = day
    dateComponents.month = month
    dateComponents.year = year
    
    guard let date = calendar.date(from: dateComponents) else {
        print("Could not make date from DateComponents")
        return
    }
    
    dayRecord.date = date
    let habitNames = habits.map { $0.name }
    dayRecord.allHabits = [habitNames]
    dayRecord.doneHabits = []
    
    do {
        try dayRecord.managedObjectContext?.save()
    } catch let error {
        print("Error saving context: \(error.localizedDescription)")
    }
}

//func EditRecord

func fetchRequest(day: Int, month: Int, year: Int, context: NSManagedObjectContext) -> NSFetchRequest<Habit>? {
    
   // let dayOfWeek = whichDayOfWeek(day: day, month: month, year: year)!
    
    guard let dayOfWeek = whichDayOfWeek(day: day, month: month, year: year) else {
            print("Invalid Date Format")
            return nil
        }
     
        
        let request: NSFetchRequest<Habit> = NSFetchRequest<Habit>(entityName: "Habit")
        
        // Create predicate for the specific day of the week
    let predicateFormat = "isRepeatedOn\(dayOfWeek) == %@"
    let predicate = NSPredicate(format: predicateFormat, argumentArray: [true])
       request.predicate = predicate
        
        return request
}

import CoreData

func fetchRequestForTrackedHabits(day: Int, month: Int, year: Int, context: NSManagedObjectContext) -> NSFetchRequest<TrackedHabitsByDate>? {
    
    let request: NSFetchRequest<TrackedHabitsByDate> = NSFetchRequest<TrackedHabitsByDate>(entityName: "TrackedHabitsByDate")
    
    let calendar = Calendar.current
    

    var dateComponents = DateComponents()
    dateComponents.day = day
    dateComponents.month = month
    dateComponents.year = year
    
    guard let date = calendar.date(from: dateComponents) else {
        print("Error creating date from components")
        return nil
    }
    
    // Create the start and end of the day for the predicate
    let startOfDay = calendar.startOfDay(for: date)
    let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
    
    let predicate = NSPredicate(format: "date >= %@ AND date < %@", argumentArray: [startOfDay, endOfDay])
    request.predicate = predicate
    
    return request
}





func getMonthNumber(from monthString: String) -> Int {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM"
    if let monthNumber = dateFormatter.monthSymbols.firstIndex(of: monthString.capitalized) {
        return monthNumber + 1
    }
    return 1 // Default to January if the month string is invalid
}






