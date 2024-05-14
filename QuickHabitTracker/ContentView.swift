//
//  ContentView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 24.04.2024.
//

import SwiftUI
import WidgetKit


import SwiftUI
import WidgetKit

struct ContentView: View {
    
    
    @AppStorage("firstHabitStatus", store: UserDefaults(suiteName: "group.com.devNoyan.QuickHabitTracker")) var firstHabitStatus: Bool = false
    @State private var habitStatus: Bool = false
    @State private var showCreateHabitView: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                
                NavigationLink(destination: CreateHabitView()) {
                    Text("Create Habit")
                }
                
                NavigationLink(destination: fetchBydateView()) {
                    Text("Sunday Habits")
                }
                
                
                NavigationLink(destination: MontlyHistoryView()) {
                    Text("Monthly History")
                }
                
                Button("Toggle") {
                    firstHabitStatus.toggle()
                    WidgetCenter.shared.reloadAllTimelines()
                    habitStatus = getHabitStatus()
                }
                
                NavigationLink {
                    HabitlistView()
                } label: {
                    Text("Habit List")
                }


                Text("\(habitStatus)")
                
               
                Divider()
            }
           
            .onChange(of: firstHabitStatus) { _ in
                habitStatus = getHabitStatus()
            }
            .onAppear {
                habitStatus = getHabitStatus()
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
                CreateHabitView()
            }
           
            .navigationTitle("Today's Habits")
        }
    }

    func updateHabitStatus() {
        habitStatus = getHabitStatus()
    }

    func getHabitStatus() -> Bool {
        if let store = UserDefaults(suiteName: "group.com.devNoyan.QuickHabitTracker") {
            let value = store.bool(forKey: "firstHabitStatus")
            return value
        } else {
            return false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


