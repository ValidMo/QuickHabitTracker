//
//  ActiveHabitsView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 24.05.2024.
//

import SwiftUI
import CoreData

struct HabitListOnWeekdaysView: View {
    
    @FetchRequest(sortDescriptors: []) var habits: FetchedResults<Habit>
    
    let weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var body: some View {
        
        List{
            ForEach(weekdays, id: \.self){ weekday in
                Section(header: Text(weekday).font(.headline)){
                    
                    let filteredHabits = filterHabits(for: weekday)
                    ForEach(filteredHabits, id: \.self){ habit in
                        HStack{
                            Text(habit.name)
                        }
                    }
                    
                    
                }
            }
        }
        .navigationTitle("Habit List")
        //.listStyle(GroupedListStyle())
        
        
    }
    private func filterHabits(for weekday: String) -> [Habit] {
        
        let shortWeekday = weekday.prefix(3).lowercased()
        
        switch shortWeekday {
        case "mon":
            return habits.filter { $0.isRepeatedOnMon }
        case "tue":
            return habits.filter { $0.isRepeatedOnTue }
        case "wed":
            return habits.filter { $0.isRepeatedOnWed }
        case "thu":
            return habits.filter { $0.isRepeatedOnThu }
        case "fri":
            return habits.filter { $0.isRepeatedOnFri }
        case "sat":
            return habits.filter { $0.isRepeatedOnSat }
        case "sun":
            return habits.filter { $0.isRepeatedOnSun }
        default:
            return []
        }
    }
}

#Preview {
    HabitListOnWeekdaysView()
}
