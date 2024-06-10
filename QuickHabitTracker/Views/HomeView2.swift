//
//  HomeView2.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 10.06.2024.
//

import SwiftUI

struct HomeView2: View {
    
    @State var day: Int = Calendar.current.component(.day, from: Date())
    @State var month: Int = Calendar.current.component(.day, from: Date())
    @State var year: Int = Calendar.current.component(.day, from: Date())
    
    @Environment(\.managedObjectContext) var context
    
    @State private var records: [Record] = []
    @State private var habits: [Habit] = []
    @State private var tempHabits: [String] = []
    
    let coreDataHelper = CoreDataHelper.shared
    
    var body: some View {
        VStack {
            if !habits.isEmpty && !records.isEmpty {
                ForEach(habits) { habit in
                        Button(action: {
                            if tempHabits.contains(habit.name.lowercased()) {
                                records.first?.doneHabits?.removeAll { $0 == habit.name.lowercased() }
                                tempHabits.removeAll { $0.lowercased() == habit.name.lowercased() }
//                                printAll()
                                refreshRecords()
                                }
                                
                            
                             else {
                                records.first?.doneHabits?.append(habit.name.lowercased())
                                tempHabits.append(habit.name.lowercased())
//                                printAll()
                                refreshRecords()
                            }
                        }, label: {
                            Text(formatHabitName(habit.name))
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                        })
                        .buttonStyle(PressableButtonStyle(
                            pressedColor: .green.opacity(0.8),
                            unpressedColor: .gray.opacity(0.5),
                            isPressed: tempHabits.contains(habit.name.lowercased())))
                        
                        .contextMenu {
                            Button("Undone Habit", role: .destructive) {
                                if tempHabits.contains(habit.name.lowercased()) {
                                    records.first?.doneHabits?.removeAll { $0 == habit.name.lowercased() }
                                    tempHabits.removeAll { $0.lowercased() == habit.name.lowercased() }
//                                    printAll()
                                    refreshRecords()
                                    }
                            }
                        }
                        
                    
                }
            }
            else if records.isEmpty {
                ForEach(habits) { habit in
                    Button {
                        coreDataHelper.createRecord(habit: habit, context: context, day: day, month: month, year: year)
                        tempHabits.append(habit.name.lowercased())
                        refreshRecords()
//                        printAll()
                        
                    } label: {
                        Text(formatHabitName(habit.name))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .buttonStyle(PressableButtonStyle(
                        pressedColor: .green.opacity(0.8),
                        unpressedColor: .gray.opacity(0.5),
                        isPressed: false))
                }
            }
            else {
                Text("no habits for today")
            }
             
        }
        .onAppear {
            fetchData()
            refreshRecords()
            
        }
    }
    
    private func fetchData() {
      
    
        if let request = fetchRequest(day: day, month: month, year: year, context: context) {
            do {
                habits = try context.fetch(request)
                print("Fetched habits: \(habits.count)")
            } catch {
                print("Error fetching data: \(error)")
            }
        } else {
            print("Bad request while fetching habits related to the date")
        }
        
        if let request = fetchRequestForTrackedHabits(day: day, month: month, year: year, context: context) {
            do {
                records = try context.fetch(request)
                //  tempHabits = records.map { TempHabit(habitName: $0.records.first?.doneHabits) }
                print("Fetched records: \(records.count)")
             
            } catch {
                print("Error fetching data: \(error)")
            }
        } else {
            print("Bad request while fetching tracked habits")
        }
        
        if let doneHabits = records.first?.doneHabits {
            tempHabits = doneHabits.map { $0 }
        }
    }
 
    
    private func refreshRecords() {
        if let request = fetchRequestForTrackedHabits(day: day, month: month, year: year, context: context) {
            do {
                records = try context.fetch(request)
                //  tempHabits = records.map { TempHabit(habitName: $0.records.first?.doneHabits) }
                print("Fetched records: \(records.count)")
                print("records refreshed")
             
            } catch {
                print("Error fetching data: \(error)")
            }
        } else {
            print("Bad request while fetching tracked habits")
        }
//        if let doneHabits = records.first?.doneHabits {
//            tempHabits = doneHabits.map { $0 }
//        }

    }
    
    
}

//#Preview {
//    HomeView2()
//}