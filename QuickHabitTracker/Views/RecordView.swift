//
//  RecordView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 8.05.2024.
//

import SwiftUI
import CoreData


struct RecordView: View {
    
    @State var day: Int
    @State var month: Int
    @State var year: Int
    
    
    @Environment(\.managedObjectContext) var context
    @State private var records: [Record] = []
    @State private var habits: [Habit] = []
    
    let coreDataHelper = CoreDataHelper.shared
    
    var body: some View {
       
           List {
               
                Section("Day Records"){
                    if !records.isEmpty{
                        
                        ForEach(records){ record in
                            if let doneHabits = record.doneHabits {
                                ForEach(doneHabits, id: \.self) { habit in
                                    Text(habit)
                                }
                                
                            }
                            else {
                                Text("No Done Habit found in record!")
                            }
                        }
                    
                            Divider()
                        }
                        else {
                            HStack{
                                Text("No Record Found, to add record click on habits list below ")
                                    .italic()
                                    .foregroundStyle(.gray)
                            }
                        }
                    
                }
                
                Section("Day's Habits"){
                    VStack{
                        if !habits.isEmpty{
                        ForEach(habits){ habit in
                            Button(habit.name) {
                                if let record = checkForRecordedDay(day: day, month: month, year: year, context: context).first {
                                    if var doneHabits = record.doneHabits  {
                                        if !doneHabits.contains((habit.name).lowercased()) {
                                            doneHabits.append((habit.name).lowercased())
                                            record.doneHabits = doneHabits
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
                                } else {
                                    coreDataHelper.createRecord(habit: habit, context: context, day: day, month: month, year: year)
                                    print("Record Created")
                                }
                            }
                        }
                    }
                        else {
                            Text("No Habits found for today!")
                                .italic()
                                .foregroundStyle(.gray)
                        }
                    }
                }
                
           }
          
           .padding(.top, 0)

        

        .onAppear {
            
            if let request = fetchRequest(day: day, month: month, year: year, context: context) {
                do {
                    habits = try context.fetch(request)
                    // Use the fetched habits here
                    print("Fetched habits: \(habits.count)")
                } catch {
                    print("Error fetching data: \(error)")
                }
            } else {
                print("bad request while fetching habits related to the date")
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
                print("bad request while fetching TrackedDays")
            }
            
        }
        
    }
    
   
}









/*
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
 } */








