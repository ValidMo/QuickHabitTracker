//
//  DayView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 8.05.2024.
//

import SwiftUI
import CoreData

struct DayView: View {
    
    @State var day: Int
    @State var month: Int
    @State var year: Int
    
    @Environment(\.managedObjectContext) var context
    
    @State private var habits: [Habit] = []
    
    var body: some View {
            List {
                habitsList
            }
        .onAppear {
            if let request = fetchRequest(day: day, month: month, year: year, context: context) {
                do {
                    habits = try context.fetch(request)
                    // Use the fetched habits here
                    print("Fetched habits: \(habits.count)") // Example usage
                } catch {
                    print("Error fetching data: \(error)")
                }
            } else {
                print("bad request")
            }
        }
    }
    
    @ViewBuilder
    var habitsList: some View {
        if habits.isEmpty {
            Text("No habits found")
        } else {
            ForEach(habits, id: \.self) { habit in
                Text(habit.name) // Assuming 'name' is the property you want to display
            }
        }
    }
}

    
    
    func fetchRequest(day: Int, month: Int, year: Int, context: NSManagedObjectContext) -> NSFetchRequest<Habit>? {
        
        let dayOfWeek = whichDayOfWeek(day: day, month: month, year: year)!
        /*
        guard let dayOfWeek = whichDayOfWeek(day, month: month, year: year) else {
                print("Invalid Date Format")
                return nil
            }
         */
            
            let request: NSFetchRequest<Habit> = NSFetchRequest<Habit>(entityName: "Habit")
            
            // Create predicate for the specific day of the week
        let predicateFormat = "isRepeatedOn\(dayOfWeek) == %@"
        let predicate = NSPredicate(format: predicateFormat, argumentArray: [true])
           request.predicate = predicate
            
            return request
    }
    
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



