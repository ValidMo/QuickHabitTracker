//
//  GithubLikeView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 2.06.2024.
//

import SwiftUI

struct GithubLikeView: View {
    let daysInMonth = 30 // Replace with the actual number of days in the month
        let weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

        var body: some View {
            VStack(alignment: .leading) {
                HStack{
                    Text("April")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading, 10)
                    
                    Text("2024")
                        .foregroundStyle(.gray.opacity(0.6))
                      //  .padding(.leading, 10)
                       // .padding(.bottom, 5)
                }
               // Divider()
                HStack {
                    ForEach(weekdays, id: \.self) { weekday in
                        Text(weekday)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.gray)
                    }
                }

                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 7), spacing: 10) {
                    ForEach(0..<daysInMonth) { day in
                        Rectangle()
                            .fill(Color.green.opacity(Double(day + 1) / Double(daysInMonth)))
                            .frame(maxWidth: 40, maxHeight: 40)
                            .cornerRadius(10)
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
          
            .padding()
        }
}

#Preview {
    GithubLikeView()
}
