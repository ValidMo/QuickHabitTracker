//
//  CreateHabitView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 4.05.2024.
//

import SwiftUI
import CoreData

struct CreateHabitView: View {
    
    @Environment(\.managedObjectContext)  private var viewContext
    
    @State private var habitName: String = ""
    @State private var isRepeatedonSun: Bool = false
    @State private var isRepeatedonMon: Bool = false
    @State private var isRepeatedonTue: Bool = false
    @State private var isRepeatedonWed: Bool = false
    @State private var isRepeatedonThu: Bool = false
    @State private var isRepeatedonFri: Bool = false
    @State private var isRepeatedonSat: Bool = false
    

    var body: some View {
        VStack(spacing: 20) {
            TextField("Habit Name", text: $habitName)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            
            HStack(spacing: 10) {
                Button {
                    isRepeatedonSun.toggle()
                } label: {
                    Text("Sun")
                    .foregroundColor(isRepeatedonSun ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedonSun ? Color.accentColor : Color(.tertiarySystemFill))
                    .cornerRadius(8)
                }
                
                Button {
                    isRepeatedonMon.toggle()
                } label: {
                    Text("Mon")
                    .foregroundColor(isRepeatedonMon ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedonMon ? Color.accentColor : Color(.tertiarySystemFill))
                    .cornerRadius(8)
                }
                
                Button {
                    isRepeatedonTue.toggle()
                } label: {
                    Text("Tue")
                    .foregroundColor(isRepeatedonTue ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedonTue ? Color.accentColor : Color(.tertiarySystemFill))
                    .cornerRadius(8)
                }
                
                Button {
                    isRepeatedonWed.toggle()
                } label: {
                    Text("Wed")
                    .foregroundColor(isRepeatedonWed ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedonWed ? Color.accentColor : Color(.tertiarySystemFill))
                    .cornerRadius(8)
                }
                
                Button {
                    isRepeatedonThu.toggle()
                } label: {
                    Text("Thu")
                    .foregroundColor(isRepeatedonThu ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedonThu ? Color.accentColor : Color(.tertiarySystemFill))
                    .cornerRadius(8)
                }
                
                Button {
                    isRepeatedonFri.toggle()
                } label: {
                    Text("Fri")
                    .foregroundColor(isRepeatedonFri ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedonFri ? Color.accentColor : Color(.tertiarySystemFill))
                    .cornerRadius(8)
                }
                
                Button {
                    isRepeatedonSat.toggle()
                } label: {
                    Text("Sat")
                    .foregroundColor(isRepeatedonSat ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedonSat ? Color.accentColor : Color(.tertiarySystemFill))
                    .cornerRadius(8)
                }

            }
            
            Button(action: {
                isRepeatedonSun = true
                isRepeatedonMon = true
                isRepeatedonTue = true
                isRepeatedonWed = true
                isRepeatedonThu = true
                isRepeatedonFri = true
                isRepeatedonSat = true

            }) {
                Text("Every Day")
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            }
            
            
            
            Button(action: createHabit) {
                Text("Create New Habit")
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
    }
    

    
     func createHabit() {
        let newHabit = Habit(context: viewContext)
        newHabit.id = UUID()
        newHabit.name = habitName
        newHabit.isRepeatedOnSun = isRepeatedonSun
        newHabit.isRepeatedOnMon = isRepeatedonMon
        newHabit.isRepeatedOnTue = isRepeatedonTue
        newHabit.isRepeatedOnWed = isRepeatedonWed
        newHabit.isRepeatedOnThu = isRepeatedonThu
        newHabit.isRepeatedOnFri = isRepeatedonFri
        newHabit.isRepeatedOnSat = isRepeatedonSat
        
        do {
            try newHabit.managedObjectContext?.save()
        } catch let error {
            print("Error saving context: \(error.localizedDescription)")
        }
         
         print("Habit Created")
    }
}

struct CreateHabitView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHabitView()
    }
}


