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
      UITestView2()
        .tabItem {
          Label("Home", systemImage: "house")
        }
        
        HabitListOnWeekdaysView()
        .tabItem {
          Label("Weekly Plan", systemImage: "list.bullet")
        }
      MonthsOfYearView()
        .tabItem {
          Label("Records", systemImage: "calendar")
        }
    }
    .accentColor(.customGreen)
  }
}

#Preview {
    ContentView()
}
