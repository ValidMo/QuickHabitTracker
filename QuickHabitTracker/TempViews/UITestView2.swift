//
//  UITestView2.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 1.06.2024.
//

import SwiftUI
import AVFoundation

struct UITestView2: View {
    
    @State private var showCreateHabitView: Bool = false
    @State private var habits: [String] = ["10 Minute Run", "Read Book", "Cold Shower", "Take Vitamins", "Call a Friend"]
    @State private var pressedHabits: Set<String> = []
    @State private var isAnimating: Bool = false
    
    var body: some View {
        NavigationStack {
            Divider()
            Spacer()
            ScrollView {
                if habits.isEmpty {
                    Text("No Habits to do")
                } else {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 16) {
                        ForEach(habits, id: \.self) { habit in
                            Button {
                                if pressedHabits.contains(habit) {
                                } else {
                                    pressedHabits.insert(habit)
                                  //  playClickSound()
                                 //   vibrateDevice()
                                    withAnimation(.bouncy) {
                                        self.isAnimating.toggle()
                                    }
                                }
                            } label: {
                                Text(habit)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(PressableButtonStyle(pressedColor: .green.opacity(0.8), unpressedColor: .gray.opacity(0.5), isPressed: pressedHabits.contains(habit)))
                            .contextMenu(ContextMenu(menuItems: {
                                Button("Undone Habit", role: .destructive) {
                                    pressedHabits.remove(habit)
                                }
                                .disabled(!pressedHabits.contains(habit))
                            }))
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 5)
                }
                Divider()
               
                GithubLikeView()
     
            }

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
                            .foregroundStyle(Color.green)
                        Image(systemName: "plus.circle")
                            .foregroundStyle(Color.green)
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
    func playClickSound() {
        AudioServicesPlaySystemSound(1020)
    }
    
    func vibrateDevice() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
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
            .frame(height: 1)
            .foregroundColor(.white)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isPressed ? pressedColor : unpressedColor)
            )
    }
}

struct githublikeView: View {
    let daysInMonth = 20 // Replace with the actual number of days in the month
    let weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(weekdays, id: \.self) { weekday in
                    Text(weekday)
                        .frame(maxWidth: .infinity)
                }
            }

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 7), spacing: 0) {
                ForEach(0..<daysInMonth) { day in
                    Rectangle()
                        .fill(Color.green.opacity(0.3)) // Adjust color and opacity as desired
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                }
            }
        }
        .padding()
    }
}
