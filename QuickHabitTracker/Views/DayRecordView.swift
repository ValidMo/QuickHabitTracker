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
    
    @State var showAddRecordView: Bool = false
    
    @Environment(\.managedObjectContext) var context
    @State private var records: [DayRecord] = []
    @State private var habits: [Habit] = []
    
    var body: some View {
       
           List {
                Section("Day Records"){
                    
                    VStack{
                        if !records.isEmpty{
                            ForEach(records){ record in
                                if let allHabits = record.allHabits {
                                    ForEach(allHabits, id: \.self) { habit in
                                        HStack{
                                            Button(habit){
                                                addHabitToDoneHabits(habit: habit, record: record)
                                            }
                                        }
                                    }
                                }
                            }
                            Divider()
                            ForEach(records){ record in
                                if let doneRecords = record.doneHabits {
                                    ForEach(doneRecords, id: \.self){ record in
                                        HStack{
                                            Text(record)
                                        }
                                    }
                                }
                                
                            }
                            
                        }
                        else {
                            HStack{
                                Text("No records ")
                                Spacer()
                                Button( action: {
                                    showAddRecordView.toggle()
                                    print("Add Record")
                                }, label:{
                                    Image(systemName: "plus")
                                })
                            }
                        }
                    }
                }
                Section("Day's Habits"){
                    VStack{
                        ForEach(habits){ habit in
                            Text("\(habit.name)")
                        }
                    }
                }
                
           }
           .sheet(isPresented: $showAddRecordView, content: {
               CreateRecordView(habits: $habits, day: $day, month: $month, year: $year)
           })
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
    
    func addHabitToDoneHabits(habit: String, record: DayRecord){
        
        if let doneHabits = record.doneHabits{
            if !doneHabits.contains(habit.lowercased()){
                record.doneHabits?.append(habit)
            }
            else {
                print("Habit already in the done list")
            }
        }
        
        
        do {
            try record.managedObjectContext?.save()
            print("habit added to doneHabits")
        } catch let error {
            print("Error saving context: \(error.localizedDescription)")
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








