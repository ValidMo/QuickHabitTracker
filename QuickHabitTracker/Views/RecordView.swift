//
//  RecordView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 8.05.2024.
//

import SwiftUI
import CoreData

/*
class TempHabit: ObservableObject {

    @Published var habits: [String] = []
   
}
 */
struct RecordView: View {
    
    @State var day: Int
    @State var month: Int
    @State var year: Int
    
    @Environment(\.managedObjectContext) var context
    
    @State private var records: [Record] = []
    @State private var habits: [Habit] = []
  
    
    @State private var tempHabits: [String] = []
    
    @State var tileColorOpacity: Double = 0

    let coreDataHelper = CoreDataHelper.shared
    
    var body: some View {
        VStack {
            if !habits.isEmpty && !records.isEmpty {
                ForEach(habits) { habit in
                        Button(action: {
                            if tempHabits.contains(habit.name.lowercased()) {
//                                records.first?.doneHabits?.removeAll { $0 == habit.name.lowercased() }
//                                tempHabits.removeAll { $0.lowercased() == habit.name.lowercased() }
//                                printAll()
//                                refreshRecords()
                                }
                                
                            
                             else {
                                records.first?.doneHabits?.append(habit.name.lowercased())
                                tempHabits.append(habit.name.lowercased())
                                printAll()
                                refreshRecords()
                                 coreDataHelper.save()
                                 tileColorOpacity = tileColor(doneHabitsCount: records.first?.doneHabits?.count, allHabitsCount: habits.count)
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
                                    printAll()
                                    refreshRecords()
                                    coreDataHelper.save()
                                    tileColorOpacity = tileColor(doneHabitsCount: records.first?.doneHabits?.count, allHabitsCount: habits.count)
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
                        printAll()
                        coreDataHelper.save()
                        tileColorOpacity = tileColor(doneHabitsCount: records.first?.doneHabits?.count, allHabitsCount: habits.count)
                        
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
             
            Rectangle()
                .fill(tileColorOpacity == 0 ? .gray : .green.opacity(tileColorOpacity))
                .frame(maxWidth: 40, maxHeight: 40)
                .cornerRadius(10)
                .aspectRatio(1, contentMode: .fit)
            
        }
        .onAppear {
            fetchData()
            refreshRecords()
            printAll()
            tileColorOpacity = tileColor(doneHabitsCount: records.first?.doneHabits?.count, allHabitsCount: habits.count)
            
        }
    }
    
    private func printAll() {
        print("habits LIST: ")
        print(habits.map { $0.name })
        print("tempHabits LIST: ")
        print(tempHabits)
        print("Record.doneHabits LIST: ")
        print(records.first?.doneHabits)
        print("===============================")
        
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
        if let doneHabits = records.first?.doneHabits {
            tempHabits = doneHabits.map { $0 }
        }

    }


    
    func formatHabitName(_ habit: String) -> String {
        guard let first = habit.first else { return habit }
        return first.uppercased() + habit.dropFirst()
    }

    private func checkIfThereIsRecordOrNot(day: Int, month: Int, year: Int, context: NSManagedObjectContext) -> Bool {
        if let request = fetchRequestForTrackedHabits(day: day, month: month, year: year, context: context){
            do {
                let records = try context.fetch(request)
                print("Fetched records: \(records.count)")
                return true
            }
            catch {
                print("Error fetching data: \(error)")
                return false
            }
            
        }
        else {
            print("bad request while fetching TrackedDays")
            return false
        }
    }
}



    
    func formatHabitName(_ habit: String) -> String {
          guard let first = habit.first else { return habit }
          return first.uppercased() + habit.dropFirst()
      }


