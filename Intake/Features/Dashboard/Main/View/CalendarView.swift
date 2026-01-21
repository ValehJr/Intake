//
//  CalendarView.swift
//  Intake
//
//  Created by Valeh Ismayilov on 21.01.26.
//

import SwiftUI

struct CalendarView: View {
    
    let range: [Date]
    let counts: [Date: Int]
    
    var body: some View {
        calendarView
    }
    
    var calendarView: some View {
        VStack(alignment: .leading, spacing: 10) {
            weekdayHeader
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 15) {
                ForEach(range, id: \.self) { date in
                    dayCell(for: date)
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.textSecondary, lineWidth: 2)
            }
        }
    }
    
    var weekdayHeader: some View {
        HStack {
            ForEach(Calendar.current.shortWeekdaySymbols, id: \.self) { symbol in
                Text(symbol)
                    .appFont(weight: .bold, size: 14, foregroundColor: .textSecondary)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func dayCell(for date: Date) -> some View {
        let isToday = Calendar.current.isDateInToday(date)
        let isFuture = date > Date.now && !isToday
        
        let dayKey = Calendar.current.startOfDay(for: date)
        let count = counts[dayKey] ?? 0
        
        VStack(spacing: 4) {
            Text(date.formatted(.dateTime.day()))
                .appFont(
                    weight: isToday ? .bold : .medium,
                    size: 16,
                    foregroundColor: isToday ? .white : (isFuture ? .textSecondary : .textPrimary)
                )
                .frame(width: 35, height: 35)
                .background {
                    if isToday {
                        Circle()
                            .fill(Color.utilityMuted)
                    }
                }
            
            if count > 0 {
                HStack(spacing: 4) {
                    Text("\(count)")
                        .appFont(weight: .medium, size: 12,foregroundColor: .textPrimary)
                    Image("cigarette-ic")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(.textPrimary)
                }
            } else {
                Spacer().frame(height: 18)
            }
        }
    }
}
