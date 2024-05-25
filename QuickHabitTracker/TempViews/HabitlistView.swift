//
//  HabitlistView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 14.05.2024.
//

import SwiftUI

struct HabitlistView: View {
    
    @FetchRequest(sortDescriptors: []) var habits: FetchedResults<TrackedHabitsByDate>
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short // You can change the style according to your preference
        return formatter
    }()
    
  //  let credits = ["12312", "1231231", "fwefwefw"]
    
    var body: some View {
        List {
            ForEach(habits) { habit in
                
                if let allHabits = habit.allHabits as? [String],let date = habit.date  { // Assuming allHabits is an array of strings
                    ForEach(allHabits, id: \.self) { habitName in
                        HStack{
                            Text(habitName)
                            Text(dateFormatter.string(from: date))
                        }
                        
                        
                    }
                }
                
              //  Text(habit)
            }
        }
    }
}


#Preview {
    HabitlistView()
}
