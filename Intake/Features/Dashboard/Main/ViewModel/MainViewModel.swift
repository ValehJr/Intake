//
//  MainViewModel.swift
//  Intake
//
//  Created by Valeh Ismayilov on 19.01.26.
//

import Foundation
import Combine
import SwiftData
import WidgetKit

@MainActor
final class MainViewModel: ObservableObject {
    @Published var user: UserEntity
    @Published var smokingCounts: [Date: Int] = [:]
    @Published var now: Date = Date()
    
    let context: ModelContext
    
    var hourRange: [Date] {
        (-2...2).compactMap { offset in
            Calendar.current.date(byAdding: .hour, value: offset, to: now)
        }
    }
    
    var dayRange: [Date] {
        return (-15...15).compactMap { offset in
            Calendar.current.date(byAdding: .day, value: offset, to: now)
        }
    }
    
    var weeklyAverage: Double {
        calculateSevenDayAverage()
    }
    
    init(context: ModelContext, user: UserEntity) {
        self.context = context
        self.user = user
        refreshSmokingCounts()
    }
    
    func refreshSmokingCounts() {
        let grouped = Dictionary(grouping: user.smokingEvents) { event in
            Calendar.current.startOfDay(for: event.timestamp)
        }
        self.smokingCounts = grouped.mapValues { $0.count }
    }
    
    func reloadUserData() {
            do {
                let descriptor = FetchDescriptor<UserEntity>()
                let users = try context.fetch(descriptor)
                
                if let freshUser = users.first {
                    self.user = freshUser
                    refreshSmokingCounts()
                }
            } catch {
                print("❌ Error reloading user: \(error)")
            }
        }
    
    
    func addSmokingEvent() {
        let event = SmokingEvent()
        user.smokingEvents.append(event)

        do {
            try context.save()
        } catch {
            print("Save failed: \(error)")
        }

        refreshSmokingCounts()
        updateWidget()
    }

    
    func eventsForHour(_ hourDate: Date) -> [SmokingEvent] {
        user.smokingEvents.filter { event in
            Calendar.current.isDate(event.timestamp, equalTo: hourDate, toGranularity: .hour)
        }
    }
    
    func countForToday() -> Int {
        let today = Calendar.current.startOfDay(for: now)
        return smokingCounts[today] ?? 0
    }
}

extension MainViewModel {
    var hasSevenDaysOfData: Bool {
        guard let firstEvent = user.smokingEvents.min(by: { $0.timestamp < $1.timestamp }) else {
            return false
        }
        
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: Date())
        let startOfFirstDay = calendar.startOfDay(for: firstEvent.timestamp)
        
        let components = calendar.dateComponents([.day], from: startOfFirstDay, to: startOfToday)
        
        return (components.day ?? 0) >= 7
    }
    
    func calculateSevenDayAverage() -> Double {
        let now = Date()
        let calendar = Calendar.current
        
        guard let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: calendar.startOfDay(for: now)) else {
            return 0.0
        }
        
        let predicate = #Predicate<SmokingEvent> { event in
            event.timestamp >= sevenDaysAgo && event.timestamp <= now
        }
        
        let descriptor = FetchDescriptor<SmokingEvent>(predicate: predicate)
        
        do {
            let count = try context.fetchCount(descriptor)
            return Double(count) / 7.0
        } catch {
            print("Fetch failed: \(error)")
            return 0.0
        }
    }
}

extension MainViewModel {
    func updateWidget() {
        WidgetCenter.shared.reloadAllTimelines()
    }
}
