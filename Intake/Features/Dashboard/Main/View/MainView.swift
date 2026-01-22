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
                HStack(spacing: 0) {
                    timeView
                    Spacer()
                    
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
            Text("Today's count: \(vm.countForToday())")
            
            Text("•")
            
            if !vm.hasSevenDaysOfData {
                Text("Average will be available after 7 days")
            } else {
                Text("7 days avg: \(String(format: "%.1f", vm.weeklyAverage))")
            }
        }
        .appFont(weight: .medium, size: 16, foregroundColor: .textPrimary)
    }
    
    var timeView: some View {
        HStack(alignment:.top,spacing: 24) {
            ForEach(vm.hourRange, id: \.self) { date in
                VStack(alignment:.center,spacing: 4) {
                    Text(formattedTime(for: date))
                    
                    let count = vm.eventsForHour(date).count
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
                    }
                    
                }
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
        } label: {
            Image(systemName: "plus.circle.fill")
                .appFont(weight: .medium, size: 32,foregroundColor: .textSecondary)
        }
    }
    
    var calendarView: some View {
        CalendarView(range: vm.dayRange,counts: vm.smokingCounts)
    }
}

#Preview {
    @Environment(\.modelContext) var modelContext
    MainView(vm: MainViewModel(context: modelContext,user: .init(name: "Valeh", email: "i.valehjr")))
}
