//
//  GithubLikeView.swift
//  QuickHabitTracker
//
//  Created by Valid Mohammadi on 2.06.2024.
//

import SwiftUI
import CoreData

struct TileView: View {
    
    
    
    @Environment(\.managedObjectContext)  private var context
    
    @StateObject  var viewModel: TileViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text("\(viewModel.months[viewModel.currentMonth - 1])")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 10)
                
                Text(String(format: "%04d", viewModel.currentYear))
                    .foregroundStyle(.gray.opacity(0.6))
         
            }
            // Divider()
            HStack {
                ForEach(viewModel.weekdays, id: \.self) { weekday in
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
                
                ForEach(1..<viewModel.dayCountOfMonth + 1) { day in
                    
                    ZStack{
                        
                        Rectangle()
                        
                            .fill(viewModel.tileColorOfDay(day: day, month: viewModel.currentMonth, year: viewModel.currentYear, context: context) == 0 ? .gray.opacity(0.3) : .green.opacity(viewModel.tileColorOfDay(day: day, month: viewModel.currentMonth, year: viewModel.currentYear, context: context) ?? 0.0))
                                                
                                           
                            .frame(maxWidth: 40, maxHeight: 40)
                            .cornerRadius(10)
                            .aspectRatio(1, contentMode: .fit)
                        
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

