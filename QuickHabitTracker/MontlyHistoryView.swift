//
//  MontlyHistoryView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 5.05.2024.
//

import SwiftUI

struct MontlyHistoryView: View {
  private let months = ["January", "February", "March", "April", "May", "June",
                         "July", "August", "September", "October", "November", "December"]

  var body: some View {
      
      
      
    NavigationStack {
    
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) { // Added spacing between columns
          ForEach(months, id: \.self) { month in
            NavigationLink(month) {
                DailyHistoryView(month: .constant(month))
            }
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 90) // Fills available space
            .background(Color.blue)
            .cornerRadius(20)
            .padding(15)
          }
        }
      
      .navigationTitle("Monthly History")
    }
  }
}

#Preview {
    MontlyHistoryView()
}
