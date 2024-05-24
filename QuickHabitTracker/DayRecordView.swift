//
//  DayRecordView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 8.05.2024.
//

import SwiftUI
import CoreData

struct DayRecordView: View {
    
    @State var day: Int
    @State var month: Int
    @State var year: Int
    
    @Environment(\.managedObjectContext) var context
    
    //  @FetchRequest(sortDescriptors: []) var records: FetchedResults<TrackedHabitsByDate>
    @State private var records: [TrackedHabitsByDate] = []
    @State private var habits: [Habit] = []
   /*
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short // You can change the style according to your preference
        return formatter
    }()
    */
    
    var body: some View {
        /*
         Button("Track Day"){
         TrackHabit(day: day, month: month, year: year, context: context)
         }
         */
        List {
          if !records.isEmpty{
                
            ForEach(records){ record in
                if let allrecords = record.allHabits as? [String],let date = record.date  {
                    ForEach(allrecords, id: \.self) { record in
                        HStack{
                            Text(record)
                          //  Text(dateFormatter.string(from: date))
                        }
                        
                        
                    }
                }
                else {
                    Text("No Records Yet")
                }
            }
                
     } //new
            
            else{
                ForEach(habits){ habit in
                    Text("\(habit.name)")
                }
            }
        }
        .onAppear {
            
         //   TrackHabit(day: day, month: month, year: 2023, context: context)
            
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
            
             
            
            if let request = fetchRequestForTrackedHabits(day: day, month: month, year: year, context: context){
                do {
                    records = try context.fetch(request)
                    print("Fetched records: \(records.count)")
                }
                catch {
                    print("Error fetching data: \(error)")
                }
                
            }
            else {
                print("bad request")
            }
            
        }
    }
    
    @ViewBuilder
    var habitsList: some View {
        if habits.isEmpty {
            Text("It seems you have not a recorded habit for this date would you like to add a record?")
                .foregroundColor(.gray)
            Button("Add Record"){
                print("wait for a while")
            }
        } else {
            ForEach(habits, id: \.self) { habit in
                Text(habit.name) // Assuming 'name' is the property you want to display
            }
        }
    }
    
    
}











