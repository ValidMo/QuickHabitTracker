//
//  ContentView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 28.05.2024.
//

import SwiftUI

struct ContentView: View {

  var body: some View {
    TabView {
      HomeView()
        .tabItem {
          Label("Home", systemImage: "house")
        }
        HabitListOnWeekdaysView()
        .tabItem {
          Label("Habits List", systemImage: "list.number")
        }
      MonthsOfYearView()
        .tabItem {
          Label("Records", systemImage: "calendar")
        }
    }
  }
}

#Preview {
    ContentView()
}
