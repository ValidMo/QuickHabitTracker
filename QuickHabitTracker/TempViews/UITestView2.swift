//
//  UITestView2.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 1.06.2024.
//

import SwiftUI

struct UITestView2: View {
    
    @State private var showCreateHabitView: Bool = false
    @State private var habits: [String] = ["Run", "Drive", "G", "Walk the Cat", "Uber", "Dance"]
    @State private var pressedHabits: Set<String> = []

    var body: some View {
        NavigationStack {
            Divider()
            Spacer()
            ScrollView {
                VStack {
                    if habits.isEmpty {
                        Text("No Habits to do")
                    } else {
                        ForEach(habits, id: \.self) { habit in
                            Button {
                               
                                if pressedHabits.contains(habit) {
                                            pressedHabits.remove(habit)
                                        } else {
                                            pressedHabits.insert(habit)
                                        }
                            } label: {
                                Text(habit)
                                
                            }
                            .buttonStyle(PressableButtonStyle(pressedColor: .green, unpressedColor: .gray, isPressed: pressedHabits.contains(habit)))
                           
                            

                               
                            
                           
                        }
                    }

                    Divider()
                    Spacer()
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Quick Habit Tracker")
                        .bold()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showCreateHabitView.toggle()
                    }) {
                        Text("Add Habit")
                        Image(systemName: "plus.circle")
                    }
                    .padding()
                    .bold()
                }
            }
            .sheet(isPresented: $showCreateHabitView) {
                CreateHabitView(showCreateHabitView: $showCreateHabitView)
            }
           
            .navigationTitle("Today's Habits")
        }
    }

   

  
 
    
    
   
}

#Preview {
    UITestView2()
}

struct PressableButtonStyle: ButtonStyle {
    var pressedColor: Color
    var unpressedColor: Color
    var isPressed: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isPressed ? pressedColor : unpressedColor)
            )
    }
}
