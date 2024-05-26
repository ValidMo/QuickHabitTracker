//
//  AddRecordView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 25.05.2024.
//

import SwiftUI
import CoreData


struct AddRecordView: View {
    
    @Environment(\.managedObjectContext) var context
    @Binding var habits: [Habit]
    @Binding var day: Int
    @Binding var month: Int
    @Binding var year: Int
    
    
    
    var body: some View {
        VStack{
            
            ForEach(habits) { habit in
                Button(habit.name) {
                    if let record = checkForRecordedDay(day: day, month: month, year: year, context: context).first {
                    //    if let trackedHabit = record {
                            if let doneHabits = record.doneHabits  {
                                if !doneHabits.contains((habit.name).lowercased()) {
                                    record.doneHabits?.append((habit.name).lowercased())
                                    do {
                                        try context.save()
                                    } catch {
                                        print("Error saving context: \(error)")
                                    }
                                } else {
                                    print("\(habit.name) is already in doneHabits")
                                }
                            } else {
                                print("Unable to cast doneHabits to NSMutableArray")
                            }
                       // }
//                        else {
//                            print("No tracked habits found for the specified date")
//                        }
                    } else {
                        createRecord(habits: habits)
                        print("Record Created")
                    }
                }
            }

        }
        .onAppear{
            
        }
    }
    func createRecord(habits: [Habit]) {
        let record = TrackedHabitsByDate(context: context)
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        
        guard let date = calendar.date(from: dateComponents) else {
            print("Error creating date from components")
            return
        }
        
        record.date = date
        record.doneHabits = []
        record.allHabits = habits.map { $0.name }
        
        do {
            
            try record.managedObjectContext?.save()
            
        } catch let error {
            print("Error saving context: \(error.localizedDescription)")
        }
        
    }
        
}



func checkForRecordedDay(day: Int, month: Int, year: Int, context: NSManagedObjectContext) -> [TrackedHabitsByDate] {

   
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
    

//#Preview {
//    AddRecordView()
//}
