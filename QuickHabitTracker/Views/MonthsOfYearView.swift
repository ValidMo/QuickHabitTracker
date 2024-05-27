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

  var body: some View {
      
      
      
   
    
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) { 
          ForEach(months, id: \.self) { month in
            NavigationLink(month) {
                DaysOfMonthView(month: .constant(month), currentYear: calculateYear())
            }
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 90)
            .background(Color.blue)
            .cornerRadius(20)
            .padding(15)
          }
        }
      
      .navigationTitle("Monthly History")
    
  }
}

#Preview {
    MonthsOfYearView()
}
