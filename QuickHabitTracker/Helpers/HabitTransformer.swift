//
//  HabitTransformer.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 26.05.2024.
//

import Foundation

@objc(AllHabitsTransformer)
class AllHabitsTransformer: ValueTransformer {
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let allHabits = value as? [String] else { return nil }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: allHabits, requiringSecureCoding: false)
            return data
        } catch {
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        do {
            let allHabits = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, NSString.self], from: data) as? [String]
            return allHabits
        } catch {
            return nil
        }
    }
}



@objc(DoneHabitsTransformer)
class DoneHabitsTransformer: ValueTransformer {
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let doneHabits = value as? [String] else { return nil }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: doneHabits, requiringSecureCoding: false)
            return data
        } catch {
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        do {
            let doneHabits = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, NSString.self], from: data) as? [String]
            return doneHabits
        } catch {
            return nil
        }
    }
}



