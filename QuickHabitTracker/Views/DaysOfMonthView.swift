//
//  DailyHistoryView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 5.05.2024.
//

import SwiftUI

struct DaysOfMonthView: View {
    @Binding var month: String
    
    @State var currentYear: Int

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
                                   , GridItem(.flexible())], spacing: 8) {
                   ForEach(days, id: \.self) { day in
                       NavigationLink(destination: RecordView(day: day, month: getMonthNumber(from: month), year: currentYear)) {
                           Text("\(day)")
                               .foregroundColor(.white)
                               .frame(width: 30, height: 30)
                               .background(Color.blue)
                               .cornerRadius(40)
                               .padding(15)
                       }
                   }
               }
               
               
         
           
          
       }
    
  

}




#Preview {
    DaysOfMonthView(month: .constant("May"), currentYear: 2024)
}






