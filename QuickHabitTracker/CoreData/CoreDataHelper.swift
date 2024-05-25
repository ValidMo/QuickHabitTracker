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
    
    
    
    
}

