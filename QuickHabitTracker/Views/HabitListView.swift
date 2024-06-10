//
//  HabitListView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 5.06.2024.
//

import SwiftUI
import CoreData

struct HabitListView: View {
  @FetchRequest(sortDescriptors: []) var habits: FetchedResults<Habit>
  let coreDataHelper = CoreDataHelper.shared

  @State var showEditHabitListView: Bool = false

  var body: some View {
    NavigationStack {
      List {
        if habits.isEmpty {
          
          Text("No Habits Yet")
            .foregroundColor(.gray)
            .fontWeight(.light)
            .italic()
            .frame(maxWidth: .infinity, alignment: .center)
        } else {
          ForEach(habits) { habit in
            NavigationLink(destination: {
              EditHabitView(habit: habit)
            }, label: {
              HStack {
                Text("\(habit.name)")
              }
            })
          }
          .onDelete(perform: deleteHabit)
        }
      }
      .navigationTitle("Habits")
    }
  }

  private func deleteHabit(at offsets: IndexSet) {
    offsets.forEach { index in
      let habit = habits[index]
      coreDataHelper.deleteHabit(habit: habit)
    }
  }
}
