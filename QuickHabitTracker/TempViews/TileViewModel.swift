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
    
    
    
    
    
    
    
    
    
}
