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
    @State private var tempHabits: Set<String> = []
    
    let coreDataHelper = CoreDataHelper.shared
    
    var body: some View {
        
        VStack{
            if !tempHabits.isEmpty{
                if let doneHabits = records.first?.doneHabits {
                    ForEach(doneHabits, id: \.self){ habit in
                        if tempHabits.contains(habit.lowercased()){
                            Text("\(habit)")
                                .foregroundStyle(.green)
                        }
                        else {
                            Text("\(habit)")
                                .foregroundStyle(.gray)
                        }

                    }
                }
                else{
                    let tempHabitsArray = Array(tempHabits)
                    ForEach(tempHabitsArray, id: \.self){ habit in
                        Text(habit)
                            .foregroundStyle(.gray)
                    }
                }
            }
            else{
                Text("No Habits for this day is assigned")
            }
            
            
        }
        .onAppear {
            
            if let request = fetchRequest(day: day, month: month, year: year, context: context) {
                do {
                    habits = try context.fetch(request)
                    tempHabits = Set(habits.map{ $0.name.lowercased()})
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
    
    
    
    #Preview(body: {
        recordViewPreview()
    })
    
    
    
    
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
    
    
    struct recordViewPreview: View {
        
        @State var day: Int = 12
        @State var month: Int = 12
        @State var year: Int = 2024
        
        
        
        @State private var records: [String] = []
        @State private var habits: [String] = ["Take Vitamins", "Walk for 10 minutes", "Cinema"]
        
        let coreDataHelper = CoreDataHelper.shared
        var body: some View {
            
            List {
                
                Section("Done Habits"){
                    if !records.isEmpty{
                        
                        ForEach(records, id: \.self){ record in
                            Text("\(record)")
                            
                        }
                        
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
                    if !habits.isEmpty{
                        ForEach(habits, id: \.self){ habit in
                            Button {
                                if !records.contains((habit).lowercased()) {
                                    records.append((habit).lowercased())
                                } else {
                                    print("\(habit) is already in doneHabits")
                                }
                            } label: {
                                Text(habit)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.green)
                                
                            }
                            .padding()
                            
                        }
                        
                    }
                    else {
                        Text("No Habits found for today!")
                            .italic()
                            .foregroundStyle(.gray)
                    }
                    
                }
                
                
            }
            
            .padding(.top, 0)
            
            
            
        }
        
    }
    
    
    
    
    
    
}
