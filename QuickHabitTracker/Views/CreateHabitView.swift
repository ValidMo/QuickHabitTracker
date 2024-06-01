//
//  CreateHabitView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 4.05.2024.
//

import SwiftUI
import CoreData

struct CreateHabitView: View {
    
    @Environment(\.managedObjectContext)  private var context
    
    @State private var habitName: String = ""
    @State private var isRepeatedOnSun: Bool = false
    @State private var isRepeatedOnMon: Bool = false
    @State private var isRepeatedOnTue: Bool = false
    @State private var isRepeatedOnWed: Bool = false
    @State private var isRepeatedOnThu: Bool = false
    @State private var isRepeatedOnFri: Bool = false
    @State private var isRepeatedOnSat: Bool = false
    
    let coreDataHelper = CoreDataHelper.shared
    
    @Binding var showCreateHabitView: Bool
    

    var body: some View {
        VStack(spacing: 20) {
            
            Text("Create a Habit")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            TextField("Habit Name", text: $habitName)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            
            HStack(spacing: 10) {
                Button {
                    isRepeatedOnSun.toggle()
                } label: {
                    Text("Sun")
                    .foregroundColor(isRepeatedOnSun ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedOnSun ? Color.accentColor : Color(.tertiarySystemFill))
                    .cornerRadius(8)
                }
                
                Button {
                    isRepeatedOnMon.toggle()
                } label: {
                    Text("Mon")
                    .foregroundColor(isRepeatedOnMon ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedOnMon ? Color.accentColor : Color(.tertiarySystemFill))
                    .cornerRadius(8)
                }
                
                Button {
                    isRepeatedOnTue.toggle()
                } label: {
                    Text("Tue")
                    .foregroundColor(isRepeatedOnTue ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedOnTue ? Color.accentColor : Color(.tertiarySystemFill))
                    .cornerRadius(8)
                }
                
                Button {
                    isRepeatedOnWed.toggle()
                } label: {
                    Text("Wed")
                    .foregroundColor(isRepeatedOnWed ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedOnWed ? Color.accentColor : Color(.tertiarySystemFill))
                    .cornerRadius(8)
                }
                
                Button {
                    isRepeatedOnThu.toggle()
                } label: {
                    Text("Thu")
                    .foregroundColor(isRepeatedOnThu ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedOnThu ? Color.accentColor : Color(.tertiarySystemFill))
                    .cornerRadius(8)
                }
                
                Button {
                    isRepeatedOnFri.toggle()
                } label: {
                    Text("Fri")
                    .foregroundColor(isRepeatedOnFri ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedOnFri ? Color.accentColor : Color(.tertiarySystemFill))
                    .cornerRadius(8)
                }
                
                Button {
                    isRepeatedOnSat.toggle()
                } label: {
                    Text("Sat")
                    .foregroundColor(isRepeatedOnSat ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedOnSat ? Color.accentColor : Color(.tertiarySystemFill))
                    .cornerRadius(8)
                }

            }
            
            Button(action: {
                isRepeatedOnSun = true
                isRepeatedOnMon = true
                isRepeatedOnTue = true
                isRepeatedOnWed = true
                isRepeatedOnThu = true
                isRepeatedOnFri = true
                isRepeatedOnSat = true

            }) {
                Text("Every Day")
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            }
            
            Button(action: {
                coreDataHelper.createHabit(context: context, name: habitName, isRepeatedOnSun: isRepeatedOnSun, isRepeatedOnMon: isRepeatedOnMon, isRepeatedOnTue: isRepeatedOnTue, isRepeatedOnWed: isRepeatedOnWed, isRepeatedOnThu: isRepeatedOnThu, isRepeatedOnFri: isRepeatedOnFri, isRepeatedOnSat: isRepeatedOnSat)
                
                showCreateHabitView.toggle()
            }, label: {
                Text("Create Habit")
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background((habitName.isEmpty) ? Color.green.opacity(0.4) : Color.green)
                    .cornerRadius(10)
            })
            .disabled(habitName.isEmpty)
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
    }
    

    
     
}

struct CreateHabitView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHabitView(showCreateHabitView: .constant(false))
    }
}




