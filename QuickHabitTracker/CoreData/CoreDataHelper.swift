//
//  CoreDataHelper.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 1.05.2024.
//

import Foundation
import CoreData

class CoreDataHelper: ObservableObject {
    static let shared = CoreDataHelper()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "model")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    private init() {}

    func save() {
        
        guard persistentContainer.viewContext.hasChanges else { return }
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save the context:", error.localizedDescription)
        }
    }
    
    
    //MARK: - Functions related to "Habit"
    
    func createHabit(context: NSManagedObjectContext, name: String, isRepeatedOnSun: Bool,
                     isRepeatedOnMon: Bool, isRepeatedOnTue: Bool, isRepeatedOnWed: Bool, isRepeatedOnThu: Bool, isRepeatedOnFri: Bool, isRepeatedOnSat: Bool) {
       let newHabit = Habit(context: context)
       newHabit.id = UUID()
       newHabit.name = name
       newHabit.isRepeatedOnSun = isRepeatedOnSun
       newHabit.isRepeatedOnMon = isRepeatedOnMon
       newHabit.isRepeatedOnTue = isRepeatedOnTue
       newHabit.isRepeatedOnWed = isRepeatedOnWed
       newHabit.isRepeatedOnThu = isRepeatedOnThu
       newHabit.isRepeatedOnFri = isRepeatedOnFri
       newHabit.isRepeatedOnSat = isRepeatedOnSat
       
       save()
        
       print("Habit Created")
   }
    
    func deleteHabit(habit: Habit) {
        
        let context = persistentContainer.viewContext
        context.delete(habit)
        
        save()
        
        print("Habit deleted")
        
    }

    func editHabit(habit: Habit, name: String, isRepeatedOnSun: Bool, isRepeatedOnMon: Bool, isRepeatedOnTue: Bool, isRepeatedOnWed: Bool, isRepeatedOnThu: Bool, isRepeatedOnFri: Bool, isRepeatedOnSat: Bool){
        
        habit.name = name
        habit.isRepeatedOnSun = isRepeatedOnSun
        habit.isRepeatedOnMon = isRepeatedOnMon
        habit.isRepeatedOnTue = isRepeatedOnTue
        habit.isRepeatedOnWed = isRepeatedOnWed
        habit.isRepeatedOnThu = isRepeatedOnThu
        habit.isRepeatedOnFri = isRepeatedOnFri
        habit.isRepeatedOnSat = isRepeatedOnSat
        
       save()
        
        print("Habit edited")
    }
    
    
    //MARK: - Functions related to "Record"
    
    func createRecord(habit: Habit, context: NSManagedObjectContext, day: Int, month: Int, year: Int) {
        let record = Record(context: context)
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
        record.doneHabits = [habit.name.lowercased()]
       
        
       save()
        
        print("Record Created")
        
    }
    
    func deleteRecord(record: Record){
        let context = persistentContainer.viewContext
        context.delete(record)
        
        save()
        
        print("Record Deleted")
        
    }
    
    func deleteHabitFromRecordsDoneHabits(record: Record, habit: String){
        
        if var doneHabits = record.doneHabits {
            doneHabits.removeAll{ $0.lowercased() == habit.lowercased()}
            record.doneHabits = doneHabits
        }
        else {
            deleteRecord(record: record)
        }
    }
    
    func addHabitToDoneHabits(habit: String, record: Record){
        
        if let doneHabits = record.doneHabits{
            if !doneHabits.contains(habit.lowercased()){
                record.doneHabits?.append(habit)
            }
            else {
                print("Habit already in the done list")
            }
        }
        
        save()
    }
    
    
    
    
    /*
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
        
//                        else {
//                            print("No tracked habits found for the specified date")
//                        }
     } else {
        // createRecord(habits: habits, habit: habit)
         coreDataHelper.createRecord(habits: habits, habit: habit, context: context, day: day, month: month, year: year)
         print("Record Created")
     }
     */
    
    
    
    
    
}

