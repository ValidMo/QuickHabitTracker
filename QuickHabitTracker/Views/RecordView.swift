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
    @State private var tempHabits: [TempHabit] = []
    
    struct TempHabit: Hashable {
        let uuid = UUID()
        let habitName: String
        let habitStatus: Bool
    }
    
    
    
    
    let coreDataHelper = CoreDataHelper.shared
    
    var body: some View {
        
        VStack{
            if !tempHabits.isEmpty{
                if !records.isEmpty{
                    if var doneHabits = records.first?.doneHabits {
                        
                        ForEach(tempHabits, id: \.self){ habit in
                            Button(action: {
                                if !((records.first?.doneHabits?.contains(habit.habitName.lowercased())) == nil) {
                                    records.first?.doneHabits?.append(habit.habitName.lowercased())
                                }
                            }, label: {
                                Text(formatHabitName(habit.habitName))
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    
                            })
                            .buttonStyle(PressableButtonStyle(pressedColor: .green.opacity(0.8), unpressedColor: .gray.opacity(0.5), isPressed: ((records.first?.doneHabits?.contains(habit.habitName.lowercased())) != nil)))
                            .contextMenu(ContextMenu(menuItems: {
                                Button("Undone Habit", role: .destructive) {
                
                                    if let _ = records.first, temp _.doneHabits.firstIndex(of: habit.habitName.lowercased()) {
                                        records.first?.doneHabits?.remove(at: index)
                                    }
                                    refreshRecords()
                                }
                               // .disabled(!(records.first?.doneHabits.contains(habit.habitName.lowercased())))
                            }))
                        }
                    }
                    
                }
                else {
                    
                    ForEach(habits){ habit in
                        Button {
                            coreDataHelper.createRecord(habit: habit, context: context, day: day, month: month, year: year)
                            refreshRecords()
                            
                        } label: {
                            Text(habit.name)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        .buttonStyle(PressableButtonStyle(pressedColor: .green.opacity(0.8), unpressedColor: .gray.opacity(0.5), isPressed: false))
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
                    ForEach(habits){ habit in
                        let element = TempHabit(habitName: habit.name, habitStatus: false)
                        tempHabits.append(element)
                    }
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
    
    private func checkIfHabitIsInRecords(habit: String) -> Bool {
        if let record = records.first{
            if let doneHabits = record.doneHabits {
                if doneHabits.contains(habit.lowercased()){
                    return true
                }
                return false
            }
            return false
        }
        return false
        
    }
    
    private func refreshRecords(){
        if let request = fetchRequestForTrackedHabits(day: day, month: month, year: year, context: context){
            do {
                records = try context.fetch(request)
                print("Fetched records: \(records.count)")
            }
            catch {
                print("Error fetching data: \(error)")
            }
            
        }
            .disabled(!(records.first?.doneHabits.contains(habit.habitName.lowercased())))
    }
    
    func formatHabitName(_ habit: String) -> String {
          guard let first = habit.first else { return habit }
          return first.uppercased() + habit.dropFirst()
      }
}

/*
 func checkForRecordedDay(day: Int, month: Int, year: Int, context: NSManagedObjectContext) -> [Record] {
 
 
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
 */

