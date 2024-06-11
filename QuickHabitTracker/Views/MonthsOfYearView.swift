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
    @State var selectedMonth: String = "Feb"
    
    var body: some View {
        NavigationStack {
            
            Divider()
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()),
                                GridItem(.flexible())], spacing: 0) {
                ForEach(months, id: \.self) { month in
                    let shortMonth = String(month.prefix(3))
                    Button(shortMonth) {
                        if canSelectMonth(month: month) {
                            selectedMonth = month
                        }
                    }
                    .foregroundColor(Color.white)
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: 40, minHeight: 40)
                    .background(selectedMonth == month ? Color.customGreen : (canSelectMonth(month: month) ? Color.green : Color.gray.opacity(0.3)))
                    .cornerRadius(10)
                    .padding(15)
                    .disabled(!canSelectMonth(month: month))
                }
            }
            
            Divider()
            DaysOfMonthView2(month: $selectedMonth, currentYear: currentYear)
            Spacer()
                .navigationTitle(String(format: "%04d", currentYear))
                .foregroundColor(.gray)
        }
        .onAppear {
            selectedMonth = getMonthAsString()
        }
        
    }
    
    // Function to check if month is selectable based on current date
    func canSelectMonth(month: String) -> Bool {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: Date())
        let monthIndex = getMonthNumber(from: month)
        return monthIndex <= currentMonth
    }
    
    
    
    
}


#Preview {
    MonthsOfYearView()
}

struct DaysOfMonthView2: View {
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

func canSelectDay(day: Int, month: String) -> Bool {
    let calendar = Calendar.current
    let currentDay = calendar.component(.day, from: Date())
    let currentMonth = calendar.component(.month, from: Date())
    
    let monthAsInt = getMonthAsInt()
    if monthAsInt < currentMonth {
        return true
    }
    else if (monthAsInt == currentMonth && day <= currentDay) {
        return true
    }
    return false
    
}

extension Color {
    static let customGreen = Color(red: 0/255, green: 108/255, blue: 15/255)
}



