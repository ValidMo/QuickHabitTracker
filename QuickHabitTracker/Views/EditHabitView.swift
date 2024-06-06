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
            
            HStack(spacing: 10) {
                Button {
                    isRepeatedOnSun.toggle()
                } label: {
                    Text("Sun")
                        .foregroundColor(isRepeatedOnSun ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedOnSun ? Color.customGreen : Color(.tertiarySystemFill))
                    .cornerRadius(8)
                }
                
                Button {
                    isRepeatedOnMon.toggle()
                } label: {
                    Text("Mon")
                        .foregroundColor(isRepeatedOnMon ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedOnMon ? Color.customGreen : Color(.tertiarySystemFill))
                    .cornerRadius(8)
                }
                
                Button {
                    isRepeatedOnTue.toggle()
                } label: {
                    Text("Tue")
                        .foregroundColor(isRepeatedOnTue ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedOnTue ? Color.customGreen : Color(.tertiarySystemFill))
                    .cornerRadius(8)
                }
                
                Button {
                    isRepeatedOnWed.toggle()
                } label: {
                    Text("Wed")
                        .foregroundColor(isRepeatedOnWed ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedOnWed ? Color.customGreen : Color(.tertiarySystemFill))
                    .cornerRadius(8)
                }
                
                Button {
                    isRepeatedOnThu.toggle()
                } label: {
                    Text("Thu")
                        .foregroundColor(isRepeatedOnThu ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedOnThu ? Color.customGreen : Color(.tertiarySystemFill))
                    .cornerRadius(8)
                }
                
                Button {
                    isRepeatedOnFri.toggle()
                } label: {
                    Text("Fri")
                        .foregroundColor(isRepeatedOnFri ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedOnFri ? Color.customGreen : Color(.tertiarySystemFill))
                    .cornerRadius(8)
                }
                
                Button {
                    isRepeatedOnSat.toggle()
                } label: {
                    Text("Sat")
                        .foregroundColor(isRepeatedOnSat ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isRepeatedOnSat ? Color.customGreen : Color(.tertiarySystemFill))
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
                    .background(Color.customGreen)
                    .cornerRadius(10)
            }
            
            Button(action: {
                coreDataHelper.editHabit(habit: habit, name: habitName, isRepeatedOnSun: isRepeatedOnSun, isRepeatedOnMon: isRepeatedOnMon, isRepeatedOnTue: isRepeatedOnTue, isRepeatedOnWed: isRepeatedOnWed, isRepeatedOnThu: isRepeatedOnThu, isRepeatedOnFri: isRepeatedOnFri, isRepeatedOnSat: isRepeatedOnSat)
               
                presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Text("Done")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
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

