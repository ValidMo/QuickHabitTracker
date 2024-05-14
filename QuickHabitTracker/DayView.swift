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
    
    var body: some View {
      Text("\(day)")
        .onAppear {
          if let request = fetchRequest(day: day, month: month, year: year, context: context) {
            do {
              let habits = try context.fetch(request)
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
    
    
    func fetchRequest(day: Int, month: Int, year: Int, context: NSManagedObjectContext) -> NSFetchRequest<TrackedHabitsByDate>? {
        
        let dateComponents = DateComponents(year: year, month: month, day: day)
        
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)
        
        let request: NSFetchRequest<TrackedHabitsByDate> = NSFetchRequest<TrackedHabitsByDate>(entityName: "model")
        
        guard let date = date else {
            print("Invalid Date Format")
            return nil
        }
        let predicate = NSPredicate(format: "date >= %@ AND date < %@ + 1d", date as NSDate, date as NSDate)
        request.predicate = predicate
        
        
        return request
    }
}


