//
//  ContentView.swift
//  Intake
//
//  Created by Valeh Ismayilov on 18.01.26.
//

import SwiftUI


struct MainView: View {
    @StateObject var vm: MainViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        ZStack {
            Color.backgroundPrimary
                .ignoresSafeArea(.all)
            VStack(alignment: .leading,spacing: 0) {
                titleView
                    .padding(.vertical)
                
                recordsView
                HStack(spacing: 24) {
                    timeView
                    plusButton
                }
                .padding(.vertical,24)
                Spacer()
                
                calendarView
            }
            .padding()
        }
    }
    
    var titleView: some View {
        Text("Welcome \(vm.user.name)")
            .appFont(weight: .semibold, size: 24,foregroundColor: .textPrimary)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    var recordsView: some View {
        HStack(spacing: 8) {
            Text("Today's count: \(vm.user.smokingEvents.count)")
            
            Text("•")
            
            Text("Record of the week: 1")
        }
        .appFont(weight: .medium, size: 16, foregroundColor: .textPrimary)
    }
    
    var timeView: some View {
        HStack(spacing: 24) {
            ForEach(vm.hourRange, id: \.self) { date in
                Text(formattedTime(for: date))
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.textSecondary, lineWidth: 2)
        }
    }
    
    func formattedTime(for date: Date) -> AttributedString {
        let fullString = TimeFormatter.hourly.string(from: date).lowercased()
        var result = AttributedString()
        
        for character in fullString {
            var charString = AttributedString(String(character))
            
            if character.isLetter {
                charString.font = .system(size: 12, weight: .medium)
                charString.foregroundColor = .textPrimary
                
            } else {
                charString.font = .system(size: 16, weight: .medium)
                charString.foregroundColor = .textPrimary
            }
            
            result += charString
        }
        return result
    }
    
    var plusButton: some View {
        Button {
            vm.addSmokingEvent()
            vm.printSmokingEvents()
        } label: {
            Image(systemName: "plus.circle.fill")
                .appFont(weight: .medium, size: 32,foregroundColor: .textSecondary)
        }
    }
    
    var calendarView: some View {
        VStack(alignment: .leading, spacing: 10) {
            weekdayHeader
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 15) {
                ForEach(vm.dayRange, id: \.self) { date in
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
    }
}

#Preview {
    @Environment(\.modelContext) var modelContext
    MainView(vm: MainViewModel(context: modelContext,user: .init(name: "Valeh", email: "i.valehjr")))
}
