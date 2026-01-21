//
//  MainViewModel.swift
//  Intake
//
//  Created by Valeh Ismayilov on 19.01.26.
//

import Foundation
import Combine
import SwiftData

@MainActor
final class MainViewModel: ObservableObject {
    @Published var user: UserEntity
    let context: ModelContext
    
    var hourRange: [Date] {
        let now = Date()
        return (-2...2).compactMap { offset in
            Calendar.current.date(byAdding: .hour, value: offset, to: now)
        }
    }
    
    var dayRange: [Date] {
        let now = Date()
        return (-15...15).compactMap { offset in
            Calendar.current.date(byAdding: .day, value: offset, to: now)
        }
    }
    
    init(context: ModelContext, user: UserEntity) {
        self.context = context
        self.user = user
    }
    
    func addSmokingEvent() {
        let event = SmokingEvent()
        user.smokingEvents.append(event)
    }
    
    func eventsForHour(_ hourDate: Date) -> [SmokingEvent] {
        user.smokingEvents.filter { event in
            Calendar.current.isDate(event.timestamp, equalTo: hourDate, toGranularity: .hour)
        }
    }
}
