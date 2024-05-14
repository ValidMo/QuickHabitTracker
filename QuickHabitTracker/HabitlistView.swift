//
//  HabitlistView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 14.05.2024.
//

import SwiftUI

struct HabitlistView: View {
    
    @FetchRequest(sortDescriptors: []) var habits: FetchedResults<Habit>
    
    
    
    var body: some View {
        List{
            ForEach(habits){ habit in
                Text(habit.name)
            }
        }
    }
}

#Preview {
    HabitlistView()
}
