//
//  fetchBydateView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 14.05.2024.
//

import SwiftUI
import CoreData

struct fetchBydateView: View {
    @State private var day: Int = 5
    @State private var month = 2
    @State private var year = 2023
    
    @Environment(\.managedObjectContext) var context
    
    @State private var habits: [Habit] = []
    
    var body: some View {
        VStack {
            /*
            Button("Calculate") {
                fetchHabits()
            }
             */
            
            List {
                if habits.isEmpty{
                    Text("No Habits to do")
                } else {
                    ForEach(habits) { habit in
                        Text(habit.name)
                    }
                }
            }
        }
        .onAppear{
            fetchHabits()
        }
    }
        
    
    func fetchHabits() {
        let request = fetchRequest2(day: day, month: month, year: year)
        do {
            habits = try context.fetch(request)
            print("Fetched habits: \(habits.count)")
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    private func fetchRequest2(day: Int, month: Int, year: Int) -> NSFetchRequest<Habit> {
        let dayOfWeek = whichDayOfWeek2(day: day, month: month, year: year)!
        let request: NSFetchRequest<Habit> = NSFetchRequest<Habit>(entityName: "Habit")
        
        // Assuming 'isRepeatedOn' is a boolean property on the 'Habit' entity
        let predicateFormat = "isRepeatedOn\(dayOfWeek) == %@"
        let predicate = NSPredicate(format: predicateFormat, argumentArray: [true])
        
        request.predicate = predicate
        
        return request
    }
    
    func whichDayOfWeek2(day: Int, month: Int, year: Int) -> String? {
        // Create a Calendar instance
        let calendar = Calendar.current
        
        // Create DateComponents from the provided day, month, and year
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        // Get the Date object from the DateComponents
        
        guard let date = calendar.date(from: dateComponents) else {
            print("somethingwrong")
            return nil // Return nil if the date is invalid
        }
        
        
        // Get the weekday from the Date object
        let weekday = calendar.component(.weekday, from: date)
        print(weekday)
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
}
