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
    
    private init() { }
    
    
    
    
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
       
       do {
           try newHabit.managedObjectContext?.save()
       } catch let error {
           print("Error saving context: \(error.localizedDescription)")
       }
        
        print("Habit Created")
   }
    
    func deleteHabit(habit: Habit) {
        
        let context = persistentContainer.viewContext
        context.delete(habit)
        
        do {
            try context.save()
        } catch {
            print("Failed to delete habit: \(error.localizedDescription)")
        }
        
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
        
        let context = persistentContainer.viewContext
        
        do {
            try context.save()
        } catch {
            print("Failed to edit habit: \(error.localizedDescription)")
        }
    }
    
    
    //MARK: - Functions related to "DayRecord"
    
    func createRecord(habits: [Habit], habit: Habit, context: NSManagedObjectContext, day: Int, month: Int, year: Int) {
        let record = DayRecord(context: context)
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
        record.allHabits = habits.map { $0.name }
        
        do {
            
            try record.managedObjectContext?.save()
            
        } catch let error {
            print("Error saving context: \(error.localizedDescription)")
        }
        
    }
    
    func deleteRecord(record: DayRecord){
        let context = persistentContainer.viewContext
        context.delete(record)
        
        do {
            try context.save()
        } catch {
            print("Failed to delete record: \(error.localizedDescription)")
        }
        
    }
    
    func deleteHabitFromRecordsDoneHabits(record: DayRecord, habit: String){
        
        if var doneHabits = record.doneHabits {
            doneHabits.removeAll{ $0.lowercased() == habit.lowercased()}
            record.doneHabits = doneHabits
        }
        else {
            print("no doneHabits on record!")
        }
        
        let context = persistentContainer.viewContext
        
        do {
            try context.save()
        } catch {
            print("Failed to delete habit from done habits: \(error.localizedDescription)")
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
        
        let context = persistentContainer.viewContext
        
        do {
            try context.save()
            
        } catch let error {
            print("Error while adding habit to doneHabits: \(error.localizedDescription)")
        }
    }
    
    
    
    
    
    
}

