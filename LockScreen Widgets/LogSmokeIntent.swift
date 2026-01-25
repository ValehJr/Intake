//
//  LogSmokeIntent.swift
//  Intake
//
//  Created by Valeh Ismayilov on 24.01.26.
//


import AppIntents
import SwiftData
import WidgetKit

struct LogSmokeIntent: AppIntent {
    static var title: LocalizedStringResource = "Log Cigarette"
    static var description = IntentDescription("Adds a smoking event to your log.")
    
    init() {}

    func perform() async throws -> some IntentResult {
        let container = DataController.shared.container
        let context = ModelContext(container)
        
        do {
            let user = try await MainActor.run {
                try DataController.shared.getOrCreateUser(context: context)
            }
            
            let event = SmokingEvent()
            user.smokingEvents.append(event)
            
            try context.save()
            
            WidgetCenter.shared.reloadAllTimelines()
            
            return .result()
            
        } catch {
            print("❌ [Intent] Error: \(error.localizedDescription)")
            return .result()
        }
    }
}
