//
//  QuickHabitTrackerApp.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 24.04.2024.
//

import SwiftUI

@main
struct QuickHabitTrackerApp: App {
    
    @StateObject private var coreDataHelper = CoreDataHelper.shared
    
    init() {
          registerTransformers()
      }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                //.defaultAppStorage(UserDefaults(suiteName: "group.com.devNoyan.QuickHabitTracker")!)
              .environment(\.managedObjectContext, coreDataHelper.persistentContainer.viewContext)
        }
    
    }
    
    private func registerTransformers() {
           ValueTransformer.setValueTransformer(DoneHabitsTransformer(), forName: NSValueTransformerName(rawValue: "DoneHabitsTransformer"))
           ValueTransformer.setValueTransformer(AllHabitsTransformer(), forName: NSValueTransformerName(rawValue: "AllHabitsTransformer"))
       }
}
