//
//  UITest.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 16.05.2024.
//

import SwiftUI

struct UITest: View {
    
    @State private var records: [String] = ["Walk", "Run", "Drive"]
    @State private var habits: [String] = ["TV", "Wash", "Workout"]
    
    var body: some View {
        
        List {
            
            Section("Day Records") {
                ForEach(records, id: \.self) { record in
                    Text(record)
                }
            }
            .listRowBackground(Color.green.opacity(0.1)) // Change the background color of the section rows
             // Change the text case of the section header
            //.font(.title2.bold()) // Change the font and weight of the section header
            
            Section("Day's Habits") {
                
                if !habits.isEmpty {
                    ForEach(habits, id: \.self) { habit in
                        Button(habit) {}
                    }
                } else {
                    Text("No Habits found for today!")
                        .italic()
                        .foregroundStyle(.gray)
                }
            }
            .listRowInsets(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)) // Change the insets (padding) of the section rows
            .headerProminence(.increased) // Increase the prominence (size) of the section header
        }
        .padding(.top, 0)
    }
}

#Preview {
    UITest()
}
