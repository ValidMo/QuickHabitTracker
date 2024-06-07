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
    
    @State private var showCreateHabitView: Bool = false
    
    let weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var body: some View {
        NavigationStack{
            Divider()
        LazyVGrid(columns: [GridItem(.fixed(120)), GridItem(.fixed(120)), GridItem(.fixed(120))], spacing: 70){
            
            ForEach(weekdays, id: \.self){ weekday in
                let filteredHabits = filterHabits(for: weekday)
                if !filteredHabits.isEmpty{
                    VStack(alignment: .leading){
                    
                        Text("\(weekday)")
                            .fontWeight(.semibold)
                            .foregroundColor((weekday.lowercased() == whichDayOfWeek()?.lowercased()) ? .green : .black)
                            
                        Divider()
                            .frame(width: 40)
                        ScrollView(.vertical, showsIndicators: false){
                        ForEach(filteredHabits, id: \.self){ habit in
                                VStack(alignment: .leading){
                                    Text("\(habit.name)")
                                        .italic(true)
                                        .foregroundColor(.gray)
                                        .lineLimit(1)
                                }
                               // .frame(maxWidth: .infinity, maxHeight: 100)
                            }
                        }
                        .frame(height: 100)
                    }
                }
                else {
                    
                    VStack(alignment: .leading){
                        
                        Text("\(weekday)")
                            .fontWeight(.semibold)
                            .foregroundColor((weekday.lowercased() == whichDayOfWeek()?.lowercased()) ? .green : .black)
                        Divider()
                        
                            .frame(width: 40)
                        ScrollView(.vertical, showsIndicators: false){
                            VStack(alignment: .leading){
                                Text("No habits set for \(weekday)")
                                    .italic(true)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                                
                                Text("lorem apsum adhjadhf")
                                    .italic(true)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                                
                                Text("lorem asjhd askjah")
                                    .italic(true)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                            }
                        }
                        .frame(height: 100)
                     
                    }
                    .padding()
                    
                }
            }
            
          
        }
        .toolbar {
            /*
            ToolbarItem(placement: .topBarLeading) {
                Text("Weekly Plan")
                .padding()
                .bold()
                .font(.title3)
            }
             */
            
            ToolbarItem(placement: .primaryAction) {
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
            
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink(destination: {
                    HabitListView()
                }, label: {
                    HStack{
                       
                        Image(systemName: "list.bullet.circle")
                            .fontWeight(.semibold)
                        Text("Habit List")

                    }
                    .foregroundStyle(.green)
                    .bold()
                }
                  
                )
                    
                
                   
               
                  }
           
        }
        .sheet(isPresented: $showCreateHabitView) {
            CreateHabitView(showCreateHabitView: $showCreateHabitView)
        }
            Spacer()
      
  
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


