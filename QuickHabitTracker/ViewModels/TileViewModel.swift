//
//  TileViewModel.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 12.06.2024.
//

import Foundation
import CoreData
import SwiftUI

class TileViewModel: ObservableObject {
    
    
    
    let weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    let months = ["January", "February", "March", "April", "May", "June",
                         "July", "August", "September", "October", "November", "December"]
    
  
    @Published var currentDay = calculateDay()
    @Published var currentMonth = calculateMonth()
    @Published var currentYear = calculateYear()
    @Published var dayCountOfMonth = calculateDayCountOfMonth()
    @Published var firstDayOfMonthWeekDay = calculateWhichDayOfWeekAMonthStarts()
    
    @Published var records: [Record] = []
    @Published var habits: [Habit] = []
    @Published var tempHabits: [String] = []
    
    func fetchRecordsOfDay(day: Int, month: Int, year: Int, context: NSManagedObjectContext) -> [Record]? {
        
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
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let predicate = NSPredicate(format: "date >= %@ AND date < %@", argumentArray: [startOfDay, endOfDay])
        request.predicate = predicate
        
        
            do {
                let records = try context.fetch(request)
                print("Fetched records: \(records.count)")
                return records
            }
            catch {
                print("Error fetching data: \(error)")
                
            }
        return nil
    }
    
    func fetchHabitsOfDay(day: Int, month: Int, year: Int, context: NSManagedObjectContext) -> [Habit]? {
        
        guard let dayOfWeek = whichDayOfWeek(day: day, month: month, year: year) else {
            print("Invalid Date Format")
            return nil
        }

        let request: NSFetchRequest<Habit> = NSFetchRequest<Habit>(entityName: "Habit")
        
        // Create predicate for the specific day of the week
        let predicateFormat = "isRepeatedOn\(dayOfWeek) == %@"
        let predicate = NSPredicate(format: predicateFormat, argumentArray: [true])
        request.predicate = predicate
        
        
            do {
                let habits = try context.fetch(request)
                print("Fetched records: \(habits.count)")
                return habits
      
            }
            catch {
                     print("Error fetching data: \(error)")
                
            }
        return nil
    }

    func tileColorOfDay(day: Int, month: Int, year: Int, context: NSManagedObjectContext) -> Double? {
        
        var recordsCount = 0
        var habitsCount = 0
        
        print(day)
        
        if let records = fetchRecordsOfDay(day: day, month: month, year: year, context: context){
            if let recordsFirstItem = records.first {
                if let recordsFirstItemDoneHabits = recordsFirstItem.doneHabits{
                    recordsCount = recordsFirstItemDoneHabits.count
                }
            }
         }
        
        if let habits = fetchHabitsOfDay(day: day, month: month, year: year, context: context){
            habitsCount = habits.count
            if habitsCount == 0 {
                return 0.0
            }
        }

        let tileColor = tileColor(doneHabitsCount: recordsCount , allHabitsCount: habitsCount)
        
        print("=========")
        print(tileColor)
        return tileColor
    }
    
    func refreshData(context: NSManagedObjectContext){
        
        fetchHabitsOfDay(day: currentDay, month: currentMonth, year: currentYear, context: context)
        
        fetchRecordsOfDay(day: currentDay, month: currentMonth, year: currentYear, context: context)
        
        print("I AM HERE")
        
    }
 
}
