//
//  DailyHistoryView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 5.05.2024.
//

import SwiftUI

struct DaysOfMonthView: View {
    @Binding var month: String
    
    @Environment(\.managedObjectContext) var context

    var days: [Int] {
        let calendar = Calendar.current
        let components = DateComponents(year: 2023, month: getMonthNumber(from: month)) // Replace 2023 with the desired year
        if let date = calendar.date(from: components) {
            let daysInMonth = calendar.range(of: .day, in: .month, for: date)?.count ?? 0
            return Array(1...daysInMonth)
        } else {
            return []
        }
    }

    var body: some View {
           
               
               LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                   ForEach(days, id: \.self) { day in
                       NavigationLink(destination: DayRecordView(day: day, month: getMonthNumber(from: month), year: 2023)) {
                           Text("\(day)")
                               .foregroundColor(.white)
                               .frame(width: 40, height: 40)
                               .background(Color.blue)
                               .cornerRadius(10)
                               .padding(15)
                       }
                   }
               }
               .navigationTitle("\(month)")
               Spacer()
           
          
       }

}




#Preview {
    DaysOfMonthView(month: .constant("May"))
}





