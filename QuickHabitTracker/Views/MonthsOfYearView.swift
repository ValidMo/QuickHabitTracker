//
//  MontlyHistoryView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 5.05.2024.
//

import SwiftUI

struct MonthsOfYearView: View {
    private let months = ["January", "February", "March", "April", "May", "June",
                           "July", "August", "September", "October", "November", "December"]

    
    @State private var currentYear: Int = calculateYear()
    @State var selectedMonth: String = "Jan"
    
    

    var body: some View {
        
        
        NavigationStack{
            
            Divider()
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
                                , GridItem(.flexible())], spacing: 0) {
                ForEach(months, id: \.self) { month in
                    let shortMonth = String(month.prefix(3))
                    Button(shortMonth) {
                        
                        selectedMonth = month
                        print(selectedMonth)
                    }
                
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: 40, minHeight: 40)
                    .background(Color.blue)
                    .cornerRadius(40)
                    .padding(15)
                }
            }
            Divider()
            DaysOfMonthView(month: $selectedMonth, currentYear: currentYear)
            Spacer()
                .navigationTitle(String(format: "%04d", currentYear))
                .foregroundColor(.gray)
        }
            
            
            
            
        
    }
}

#Preview {
    MonthsOfYearView()
}

struct DaysOfMonthView2: View {
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
                       NavigationLink(destination: DayRecordView(day: day, month: getMonthNumber(from: month), year: currentYear)) {
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



