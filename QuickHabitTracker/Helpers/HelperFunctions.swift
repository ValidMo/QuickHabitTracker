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


func whichDayOfWeek() -> String? {
    let calendar = Calendar.current
    let date = Date()
    let weekday = calendar.component(.weekday, from: date)

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
        return nil
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



func fetchRequestForTrackedHabits(day: Int, month: Int, year: Int, context: NSManagedObjectContext) -> NSFetchRequest<Record>? {
    
    let request: NSFetchRequest<Record> = NSFetchRequest<Record>(entityName: "Record")
    
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
        print(monthNumber + 1)
        return monthNumber + 1
    }
    print("1")
    return 1 // Default to January if the month string is invalid
    
}

func shortDateString(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter.string(from: date)
}


func calculateYear() -> Int {
    let calendar = Calendar.current
    let currentDate = Date()
    let currentYear = calendar.component(.year, from: currentDate)
    
    print(currentYear)
    return currentYear
}

func calculateMonth() -> Int {
    let calendar = Calendar.current
    let currentDate = Date()
    let currentMonth = calendar.component(.month, from: currentDate)
    
    print(currentMonth)
    return currentMonth
}

func calculateDay() -> Int {
    let calendar = Calendar.current
    let currentDate = Date()
    let currentDay = calendar.component(.day, from: currentDate)
    
    print(currentDay)
    return currentDay
}

func calculateDayCountOfMonth() -> Int {
   
    let calendar = Calendar.current
    let date = Date()
    let dayCount = calendar.range(of: .day, in: .month, for: date)?.count ?? 0
    
    
    return dayCount
}

func getMonthAsString() -> String {
  let formatter = DateFormatter()
  formatter.dateFormat = "MMMM"
  return formatter.string(from: Date())
}

func getDayAsInt() -> Int {
  let calendar = Calendar.current
  let components = calendar.dateComponents([.day], from: Date())
  return components.day ?? 2 // Use 1 as default if day is missing
}

func getMonthAsInt() -> Int {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.month], from: Date())
    print("***")
   // print(components.month)
    print("***")

    return components.month ?? 2
}

func checkForRecordedDay(day: Int, month: Int, year: Int, context: NSManagedObjectContext) -> [Record] {

   
    if let request = fetchRequestForTrackedHabits(day: day, month: month, year: year, context: context){
        do {
           let records = try context.fetch(request)
            print("Fetched records: \(records.count)")
            return records
        }
        catch {
            print("Error fetching data: \(error)")
           return []
        }
        
    }
    else {
        print("bad request while fetching TrackedDays")
       return []
    }
    
}

func tileColor(doneHabitsCount: Int?, allHabitsCount: Int?) -> Double {
    if let doneHabitsCount = doneHabitsCount, let allHabitsCount = allHabitsCount {
        return Double(doneHabitsCount)/Double(allHabitsCount)
    }
    return 0.0
  
}

func tileColorIteratedOnMonthDays(day: Int, month: Int, year: Int, context: NSManagedObjectContext) -> Double {
    
    var recordsCount = 0
    var habitsCount = 0
    
    print(day)
     if let request = fetchRequestForTrackedHabits(day: day, month: month, year: year, context: context){
         do {
             let records = try context.fetch(request)
             recordsCount =  records.first?.doneHabits?.count ?? 0
             print("Fetched records: \(records.count)")
             
         }
         catch {
             print("Error fetching data: \(error)")
             
         }
         
     }
    else {
        print("bad request while fetching TrackedDays")
        
    }
    
    if let request = fetchRequest(day: day, month: month, year: year, context: context) {
        do {
            let habits = try context.fetch(request)
            habitsCount = habits.count
            print("Fetched habits: \(habits.count)")
        } catch {
            print("Error fetching data: \(error)")
        }
    } else {
        print("Bad request while fetching habits related to the date")
    }
    
    if habitsCount == 0 {
        return 0.0
    }
    
    
    let tileColor = tileColor(doneHabitsCount: recordsCount , allHabitsCount: habitsCount)
    
    print("=========")
    print(tileColor)
    return tileColor
}

func calculateWhichDayOfWeekAMonthStarts() -> Int{
    let calendar = Calendar.current
    var components = DateComponents(year: calendar.component(.year, from: Date()), month: calendar.component(.month, from: Date()))
    components.day = 1
    
    if let firstDayOfMonth = calendar.date(from: components) {
        let weekday = calendar.component(.weekday, from: firstDayOfMonth)
        // Use weekday (1-based Sunday through 7-based Saturday)
        print(weekday)
        return weekday
    }
    
    
    return 1
    
    /*  let calendar = Calendar.current
     let components = DateComponents(year: currentYear, month: getMonthNumber(from: month))
     if let date = calendar.date(from: components) {
     let daysInMonth = calendar.range(of: .day, in: .month, for: date)?.count ?? 0
     return Array(1...daysInMonth)
     } else {
     return []
     }*/
}


