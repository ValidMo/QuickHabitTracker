//
//  ContentView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 24.04.2024.
//


import SwiftUI
import WidgetKit

struct HomeView: View {
    
    @State var day: Int
    @State var month: Int
    @State var year: Int
    
    @Environment(\.managedObjectContext) var context
    @State private var records: [Record] = []
    @State private var habits: [Habit] = []
    
    
    @AppStorage("firstHabitStatus", store: UserDefaults(suiteName: "group.com.devNoyan.QuickHabitTracker")) var firstHabitStatus: Bool = false
    
    @State private var habitStatus: Bool = false
    @State private var showCreateHabitView: Bool = false
    
    

    
    var body: some View {
        NavigationStack {
            VStack {

                        if habits.isEmpty{
                            Text("No Habits to do")
                        } else {
                            ForEach(habits) { habit in
                                Button(habit.name){
                                    
                                }
                            }
                        }
                    
                
                
                NavigationLink(destination: fetchBydateView()) {
                    Text("Test")
                }
                
                /*
                NavigationLink(destination: MonthsOfYearView(currentYear: $year)) {
                   Text("Monthly History")
                }
                NavigationLink(destination: HabitListOnWeekdaysView()) {
                    Text("Habits")
                }
                 */
                
                //THIS PART IS FOR WIDGET STUFF
                /*
                Button("Toggle") {
                    firstHabitStatus.toggle()
                    WidgetCenter.shared.reloadAllTimelines()
                    habitStatus = getHabitStatus()
                }
                 */
                
                
                NavigationLink {
                    RecordListView()
                } label: {
                    Text("Record List")
                }


                Text("\(habitStatus)")
                
               
                Divider()
            }
            .onAppear{
               fetchTodaysHabits()
            }
            .onChange(of: firstHabitStatus) { _ in
                habitStatus = getHabitStatus()
            }
            .onAppear {
                habitStatus = getHabitStatus()
            }
            .padding()
            .onReceive(NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave, object: context)) { _ in
                fetchTodaysHabits()
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
    
    func fetchTodaysHabits() {
        let calendar = Calendar.current
          let todayComponents = calendar.dateComponents([.day, .month, .year], from: Date())

          guard let day = todayComponents.day,
                let month = todayComponents.month,
                let year = todayComponents.year else {
            print("Error: Could not extract date components.")
            return // Handle the error gracefully (e.g., display a user-friendly message)
          }
        
        if let request = fetchRequest(day: day, month: month, year: year, context: context) {
            do {
                habits = try context.fetch(request)
                // Use the fetched habits here
                print("Fetched habits: \(habits.count)") // Example usage
            } catch {
                print("Error fetching data: \(error)")
            }
        } else {
            print("bad request")
        }
    }
    
    
   
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}


