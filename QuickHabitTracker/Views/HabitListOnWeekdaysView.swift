//
//  ActiveHabitsView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 24.05.2024.
//

import SwiftUI
import CoreData

struct HabitListOnWeekdaysView: View {
    
    @FetchRequest(sortDescriptors: []) var habits: FetchedResults<Habit>
    
    let weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var body: some View {
        NavigationStack{
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 50){
            
            ForEach(weekdays, id: \.self){ weekday in
                let filteredHabits = filterHabits(for: weekday)
                if !filteredHabits.isEmpty{
                    VStack(alignment: .leading){
                        
                        Text("\(weekday)")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Divider()
                            .frame(width: 40)
                        ForEach(filteredHabits, id: \.self){ habit in
                            ScrollView(.vertical, showsIndicators: false){
                                VStack(alignment: .leading){
                                    Text("\(habit.name)")
                                        .italic(true)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                else {
                    
                    VStack(alignment: .leading){
                        
                        Text("\(weekday)")
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                        Divider()
                        
                            .frame(width: 40)
                        ScrollView(.vertical, showsIndicators: false){
                            VStack(alignment: .leading){
                                Text("No habits set for \(weekday)")
                                    .italic(true)
                                    .foregroundColor(.gray)
                                
                            }
                        }
                        .frame(width: 100, height: 100)
                    }
                    .padding()
                    
                }
            }
            
          
        }
        .toolbar {
            
            /*
            ToolbarItem(placement: .navigationBarLeading) {
                    Text("Weekly")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.green)
               
                  }
            */
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                }, label: {
                    HStack{
                        Text("Habit List")
                        Image(systemName: "list.bullet.circle")
                            .fontWeight(.semibold)

                    }
                    .foregroundStyle(.green)
                }
                  
                )
                    
                
                   
               
                  }
           
        }
            Spacer()
       .navigationTitle("Weekly Plan")
    }
       
    }
    
    //
    private func filterHabits(for weekday: String) -> [Habit] {
        
        let shortWeekday = weekday.prefix(3).lowercased()
        
        switch shortWeekday {
        case "mon":
            return habits.filter { $0.isRepeatedOnMon }
        case "tue":
            return habits.filter { $0.isRepeatedOnTue }
        case "wed":
            return habits.filter { $0.isRepeatedOnWed }
        case "thu":
            return habits.filter { $0.isRepeatedOnThu }
        case "fri":
            return habits.filter { $0.isRepeatedOnFri }
        case "sat":
            return habits.filter { $0.isRepeatedOnSat }
        case "sun":
            return habits.filter { $0.isRepeatedOnSun }
        default:
            return []
        }
    }
}

#Preview {
  HabitListOnWeekdaysView()

    
}


/* List{
 ForEach(weekdays, id: \.self){ weekday in
     Section(header: Text(weekday).font(.headline)){
         
         let filteredHabits = filterHabits(for: weekday)
         ForEach(filteredHabits, id: \.self){ habit in
             HStack{
                 Text(habit.name)
             }
         }
         
         
     }
 }
}*/


