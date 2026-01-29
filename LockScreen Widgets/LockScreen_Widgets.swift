//
//  LockScreen_Widgets.swift
//  LockScreen Widgets
//
//  Created by Valeh Ismayilov on 24.01.26.
//

import WidgetKit
import SwiftUI
import AppIntents
import SwiftData

struct SimpleEntry: TimelineEntry {
    let date: Date
    let count: Int
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), count: 0)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), count: fetchCount())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let count = fetchCount()
        
        let entry = SimpleEntry(date: currentDate, count: count)
        
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: currentDate))!
        
        let timeline = Timeline(entries: [entry], policy: .after(tomorrow))
        
        completion(timeline)
    }
    
    func fetchCount() -> Int {
        let container = DataController.shared.container
        let context = ModelContext(container)
        
        let descriptor = FetchDescriptor<UserEntity>()
        
        do {
            let users = try context.fetch(descriptor)
            guard let user = users.first else {
                return 0
            }
            
            let todayStart = Calendar.current.startOfDay(for: Date())
            let count = user.smokingEvents.filter { $0.timestamp >= todayStart }.count
            
            return count
            
        } catch {
            print("❌ [Widget] Error fetching count: \(error.localizedDescription)")
            return 0
        }
    }
}

struct LockScreen_WidgetsEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    
    var body: some View {
        switch widgetFamily {
        case .accessoryCircular:
            circularView
        case .accessoryRectangular:
            rectangularView
        default:
            Text("Not Implemented")
        }
    }
    
    var circularView: some View {
        Button(intent: LogSmokeIntent()) {
            ZStack {
                Circle()
                    .fill(.blue.opacity(0.2))
                
                VStack(spacing: 2) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 24))
                    Text("\(entry.count)")
                        .font(.system(size: 12, weight: .semibold))
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    var rectangularView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Today")
                    .font(.system(size: 14, weight: .semibold))
                
                Text("\(entry.count) cigarettes")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Button(intent: LogSmokeIntent()) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 24))
            }
            .buttonStyle(.plain)
        }
        
    }
}

struct LockScreen_Widgets: Widget {
    let kind: String = "LockScreen_Widgets"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                LockScreen_WidgetsEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                LockScreen_WidgetsEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Smoke Tracker")
        .description("Track your daily intake.")
        .supportedFamilies([.accessoryCircular, .accessoryRectangular])
    }
}
