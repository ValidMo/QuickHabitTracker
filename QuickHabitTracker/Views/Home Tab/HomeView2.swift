//
//  HomeView2.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 10.06.2024.
//

import SwiftUI
import CoreData

struct HomeView2: View {
    
    //@State var day: Int = Calendar.current.component(.day, from: Date())
    // @State var month: Int = Calendar.current.component(.day, from: Date())
    // @State var year: Int = Calendar.current.component(.day, from: Date())
    // @State private var records: [Record] = []
    // @State private var habits: [Habit] = []
    // @State private var tempHabits: [String] = []
    
    
    @Environment(\.managedObjectContext) var context
    
    @State private var showCreateHabitView: Bool = false
    
    @StateObject var viewModel = TileViewModel()
    
    let coreDataHelper = CoreDataHelper.shared
    
    var body: some View {
        NavigationStack {
            Divider()
            
            if !viewModel.habits.isEmpty && !viewModel.records.isEmpty {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 16) {
                    ForEach(viewModel.habits) { habit in
                        Button(action: {
                            if viewModel.tempHabits.contains(habit.name.lowercased()) {
                                viewModel.records.first?.doneHabits?.removeAll { $0 == habit.name.lowercased() }
                                viewModel.tempHabits.removeAll { $0.lowercased() == habit.name.lowercased() }
                                //                                printAll()
                                viewModel.refreshData(context: context)
                            }
                            
                            
                            else {
                                viewModel.records.first?.doneHabits?.append(habit.name.lowercased())
                                viewModel.tempHabits.append(habit.name.lowercased())
                                //                                printAll()
                                viewModel.refreshData(context: context)
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
                            isPressed: viewModel.tempHabits.contains(habit.name.lowercased())))
                        
                        .contextMenu {
                            Button("Undone Habit", role: .destructive) {
                                if viewModel.tempHabits.contains(habit.name.lowercased()) {
                                    viewModel.records.first?.doneHabits?.removeAll { $0 == habit.name.lowercased() }
                                    viewModel.tempHabits.removeAll { $0.lowercased() == habit.name.lowercased() }
                                    //                                    printAll()
                                    viewModel.refreshData(context: context)
                                }
                            }
                        }
                        
                        
                    }
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
                
                if viewModel.records.isEmpty {
                    ForEach(viewModel.habits) { habit in
                        Button {
                            coreDataHelper.createRecord(habit: habit, context: context, day: viewModel.currentDay, month: viewModel.currentMonth, year: viewModel.currentYear)
                            viewModel.tempHabits.append(habit.name.lowercased())
                            viewModel.refreshData(context: context)
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
            }
            
            else {
                Text("no habits for today")
            }
            Spacer()
            Divider()
            TileView(viewModel: viewModel)
            
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Quick Habit Tracker")
                            .bold()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showCreateHabitView.toggle()
                        }) {
                            Text("Add Habit")
                                .foregroundStyle(Color.green)
                            Image(systemName: "plus.circle")
                                .foregroundStyle(Color.green)
                        }
                        .padding()
                        .bold()
                    }
                }
                .sheet(isPresented: $showCreateHabitView) {
                    CreateHabitView(showCreateHabitView: $showCreateHabitView)
                }
                .navigationTitle("Today's Habits")
            
        }
        .onAppear {
            //  fetchData()
            viewModel.refreshData(context: context)
            
            
        }
    }
    /*
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
     */
    /*
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
     */
    
    
}

//#Preview {
//    HomeView2()
//}
