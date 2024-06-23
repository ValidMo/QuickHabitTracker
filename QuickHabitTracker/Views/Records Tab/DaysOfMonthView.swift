//
//  DaysOfMonthView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 22.06.2024.
//

import SwiftUI

struct DaysOfMonthView: View {
    @Binding var month: String
    
    @State var currentYear: Int
    @State var selectedDay: Int = 1
    @State var selectedMonth: Int = 1
    
    var days: [Int] {
        
        let calendar = Calendar.current
        let components = DateComponents(year: currentYear, month: getMonthNumber(from: month))
        if let date = calendar.date(from: components) {
            let daysInMonth = calendar.range(of: .day, in: .month, for: date)?.count ?? 0
            return Array(1...daysInMonth)
        } else {
            return []
        }
    }
    
    var body: some View {
        
        
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
                            , GridItem(.flexible())
                           ], spacing: 4) {
            ForEach(days, id: \.self) { day in
                //   if canSelectDay(day: day, month: month) {
                NavigationLink(destination: RecordView(day: day, month: getMonthNumber(from: month), year: currentYear)) {
                    Text("\(day)")
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background((selectedDay == day && selectedMonth == getMonthAsInt()) ? Color.customGreen : ((selectedDay < day && selectedMonth == getMonthAsInt())) ? Color.gray.opacity(0.3) : Color.green)
                        .cornerRadius(10)
                        .padding(10)
                        
                }
                .disabled(day > getDayAsInt() - 1 && selectedMonth == getMonthAsInt())
                //   } else {
                /*
                 Text("\(day)")
                 .foregroundColor(.white)
                 .frame(width: 30, height: 30)
                 .background(Color.gray.opacity(0.3))
                 .cornerRadius(10)
                 .padding(15)
                 }
                 */
            }
        }
                           .onAppear{
                               selectedDay = getDayAsInt()
                               selectedMonth = getMonthNumber(from: month)
                               calculateWhichDayOfWeekAMonthStarts()
                           }
                           .onChange(of: month) { newValue in
                               selectedMonth = getMonthNumber(from: newValue)
                           }
        
        
        
        
        
        
        
    }
    
    
    
}
//
//#Preview {
//    DaysOfMonthView()
//}
