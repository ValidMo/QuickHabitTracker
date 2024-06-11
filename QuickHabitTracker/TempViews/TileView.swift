//
//  GithubLikeView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 2.06.2024.
//

import SwiftUI
import CoreData

struct TileView: View {
    
        let weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
        private let months = ["January", "February", "March", "April", "May", "June",
                          "July", "August", "September", "October", "November", "December"]
    
        @State var currentDay = calculateDay()
        @State var currentMonth = calculateMonth()
        @State var currentYear = calculateYear()
        @State var dayCountOfMonth = calculateDayCountOfMonth()
        @State var firstDayOfMonthWeekDay = calculateWhichDayOfWeekAMonthStarts()
    
        @Environment(\.managedObjectContext)  private var context

        var body: some View {
            VStack(alignment: .leading) {
                HStack{
                    Text("\(months[currentMonth - 1])")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading, 10)
                    
                    Text(String(format: "%04d", currentYear))
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
                   
                    ForEach(0..<calculateWhichDayOfWeekAMonthStarts() - 1){ _ in
                        Rectangle()
                            .fill(.windowBackground)
                        
                            .frame(maxWidth: 40, maxHeight: 40)
                            .cornerRadius(10)
                            .aspectRatio(1, contentMode: .fit)
                            
                           
                    }
                    
                    ForEach(1..<dayCountOfMonth + 1) { day in
                        
                        ZStack{
                            
                        Rectangle()
                                .fill(tileColorIteratedOnMonthDays(day: day, month: currentMonth, year: currentYear, context: context) == 0 ? .gray.opacity(0.3) : .green.opacity(tileColorIteratedOnMonthDays(day: day, month: currentMonth, year: currentYear, context: context)))
                        
                            .frame(maxWidth: 40, maxHeight: 40)
                            .cornerRadius(10)
                            .aspectRatio(1, contentMode: .fit)
                            
                            Text("\(day)")
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                    }
                    }
                }
            }
          
            .padding()
        }
}

#Preview {
    TileView()
}
