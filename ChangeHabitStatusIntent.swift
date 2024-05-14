//
//  Intents.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 28.04.2024.
//



import SwiftUI
import AppIntents


    struct ChangeHabitStatusIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Change Habit Status"
    
    func perform() async throws -> some IntentResult {
        if let store = UserDefaults(suiteName: "group.com.devNoyan.QuickHabitTracker"){
            let status = store.value(forKey: "firstHabitStatus") as? Bool
            store.setValue(status == false ? true : false, forKey: "firstHabitStatus")
            print("im here")
            return .result()
        }
        else {
            print("User Defaults Not found!")
            return .result()
        }
        
      
    }
        
       

    
    
}

