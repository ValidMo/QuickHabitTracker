//
//  HabitlistView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 14.05.2024.
//

import SwiftUI
import CoreData

struct RecordListView: View {
    
    @FetchRequest(sortDescriptors: []) var records: FetchedResults<Record>

    
    var body: some View {
        ScrollView{
            ForEach(records){ record in
                VStack{
                    Text(shortDateString(from: record.date))
                    /*
                    if let allHabits = record.allHabits {
                        ForEach(allHabits, id: \.self){ habit in
                            Text(habit)
                        }
                        Text("---")
                    }
                     */
                    if let doneHabits = record.doneHabits {
                        ForEach(doneHabits, id: \.self){ habit in
                            Text(habit)
                        }
                    }
                    
                }
                Divider()
            }
            
            
        }
    }
}


#Preview {
    RecordListView()
}
