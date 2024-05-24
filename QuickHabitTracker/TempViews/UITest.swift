//
//  UITest.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 16.05.2024.
//

import SwiftUI

struct UITest: View {
  var body: some View {
    let habits = ["Run", "Drive", "Bike", "Shop", "Football", "Cinema With Friends", "Watch TV"]

    NavigationView {
        ScrollView {
            Divider()
            
                ForEach(habits, id: \.self) { habit in
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text(habit)
                    })
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40)
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(10)
                }
            
        }
      .padding()
      .navigationTitle("Today's Habits") // Now inside ScrollView
    }
  }
}


#Preview {
    UITest()
}
