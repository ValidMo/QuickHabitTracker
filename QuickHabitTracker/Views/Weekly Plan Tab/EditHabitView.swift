//
//  editHabitView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 6.06.2024.
//

import SwiftUI

struct EditHabitView: View {
    @Environment(\.managedObjectContext)  private var context
    @Environment(\.presentationMode) var presentationMode
   
    
    @State private var habitName: String = ""
    @State private var isRepeatedOnSun: Bool = false
    @State private var isRepeatedOnMon: Bool = false
    @State private var isRepeatedOnTue: Bool = false
    @State private var isRepeatedOnWed: Bool = false
    @State private var isRepeatedOnThu: Bool = false
    @State private var isRepeatedOnFri: Bool = false
    @State private var isRepeatedOnSat: Bool = false
    
    @State private var allDaysChecked: Bool = false
    
    let coreDataHelper = CoreDataHelper.shared

    @State var habit: Habit
    

    var body: some View {
        VStack(spacing: 20) {
            HStack(alignment: .firstTextBaseline){
            Text("\(habitName)")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
            
            TextField("\(habitName)", text: $habitName)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            
            HStack{
                Button {
                    isRepeatedOnSun.toggle()
                } label: {
                    Text("Sunday")
                        .foregroundColor(isRepeatedOnSun ? .white : .primary)
                        .frame(width: 100, height: 40)
                        .background(isRepeatedOnSun ? .green : Color(.tertiarySystemFill))
                        .cornerRadius(8)
                }
                
                Button {
                    isRepeatedOnMon.toggle()
                } label: {
                    Text("Monday")
                        .foregroundColor(isRepeatedOnMon ? .white : .primary)
                        .frame(width: 100, height: 40)
                        .background(isRepeatedOnMon ? .green : Color(.tertiarySystemFill))
                        .cornerRadius(8)
                }
                
                Button {
                    isRepeatedOnTue.toggle()
                } label: {
                    Text("Tuesday")
                        .foregroundColor(isRepeatedOnTue ? .white : .primary)
                        .frame(width: 100, height: 40)
                        .background(isRepeatedOnTue ? .green : Color(.tertiarySystemFill))
                        .cornerRadius(8)
                }
            }
            HStack{
                
                Button {
                    isRepeatedOnWed.toggle()
                } label: {
                    Text("Wednesday")
                        .foregroundColor(isRepeatedOnWed ? .white : .primary)
                        .frame(width: 100, height: 40)
                        .background(isRepeatedOnWed ? .green : Color(.tertiarySystemFill))
                        .cornerRadius(8)
                }
                
                Button {
                    isRepeatedOnThu.toggle()
                } label: {
                    Text("Thursday")
                        .foregroundColor(isRepeatedOnThu ? .white : .primary)
                        .frame(width: 100, height: 40)
                        .background(isRepeatedOnThu ? .green : Color(.tertiarySystemFill))
                        .cornerRadius(8)
                }
                
                Button {
                    isRepeatedOnFri.toggle()
                } label: {
                    Text("Friday")
                        .foregroundColor(isRepeatedOnFri ? .white : .primary)
                        .frame(width: 100, height: 40)
                        .background(isRepeatedOnFri ? .green : Color(.tertiarySystemFill))
                        .cornerRadius(8)
                }
            }
            HStack{
                
                Button {
                    isRepeatedOnSat.toggle()
                } label: {
                    Text("Saturday")
                        .foregroundColor(isRepeatedOnSat ? .white : .primary)
                        .frame(width: 100, height: 40)
                        .background(isRepeatedOnSat ? .green : Color(.tertiarySystemFill))
                        .cornerRadius(8)
                }
                //
                
                
                Button(action: {
                    
                    allDaysChecked.toggle()
                    
                    if allDaysChecked {
                        isRepeatedOnSun = true
                        isRepeatedOnMon = true
                        isRepeatedOnTue = true
                        isRepeatedOnWed = true
                        isRepeatedOnThu = true
                        isRepeatedOnFri = true
                        isRepeatedOnSat = true
                    }
                    else {
                        isRepeatedOnSun = false
                        isRepeatedOnMon = false
                        isRepeatedOnTue = false
                        isRepeatedOnWed = false
                        isRepeatedOnThu = false
                        isRepeatedOnFri = false
                        isRepeatedOnSat = false
                    }
                }) {
                    Image(systemName: "checklist.checked")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(allDaysChecked ? .green : .gray.opacity(0.2))
                        .cornerRadius(10)
                }
            }
            
            Button(action: {
                coreDataHelper.editHabit(habit: habit, name: habitName, isRepeatedOnSun: isRepeatedOnSun, isRepeatedOnMon: isRepeatedOnMon, isRepeatedOnTue: isRepeatedOnTue, isRepeatedOnWed: isRepeatedOnWed, isRepeatedOnThu: isRepeatedOnThu, isRepeatedOnFri: isRepeatedOnFri, isRepeatedOnSat: isRepeatedOnSat)
               
                presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Text("Done")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .frame(width: 300, height: 40)
                  //  .padding(.horizontal, 20)
                   // .padding(.vertical, 10)
                    .background((habitName.isEmpty) ? Color.green.opacity(0.4) : Color.green)
                    .cornerRadius(10)
                
            
            })
            .disabled(habitName.isEmpty)
            
            
            Spacer()
            
          

        }
        .padding()
        .onAppear {
           
                habitName = habit.name
                isRepeatedOnSun = habit.isRepeatedOnSun
                isRepeatedOnMon = habit.isRepeatedOnMon
                isRepeatedOnTue = habit.isRepeatedOnTue
                isRepeatedOnWed = habit.isRepeatedOnWed
                isRepeatedOnThu = habit.isRepeatedOnThu
                isRepeatedOnFri = habit.isRepeatedOnFri
                isRepeatedOnSat = habit.isRepeatedOnSat
            
        }
    }
        
}

