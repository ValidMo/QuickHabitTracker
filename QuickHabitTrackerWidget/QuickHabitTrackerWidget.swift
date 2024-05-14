//
//  QuickHabitTrackerWidget.swift
//  QuickHabitTrackerWidget
//
//  Created by Valid Mohammadi on 24.04.2024.
//

import WidgetKit
import SwiftUI
import AppIntents



struct getHabitStatusIntent: AppIntent {
    static var title: LocalizedStringResource = "Get Habit Status"

    func perform() async throws -> some IntentResult {
        if let store = UserDefaults(suiteName: "group.com.devNoyan.QuickHabitTracker") {
            let habitStatus = store.bool(forKey: "firstHabitStatus")
            print(habitStatus)
            return .result()
        } else {
            print("User Defaults Not found!")
            return .result()
        }
    }
}
    
    



struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀", isDone: getHabitStatus())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀", isDone: getHabitStatus())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀", isDone: getHabitStatus())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
    let isDone: Bool
}

func getHabitStatus() -> Bool {
    if let store = UserDefaults(suiteName: "group.com.devNoyan.QuickHabitTracker"){
        return store.bool(forKey: "firstHabitStatus")
    } else {
        return false
    }
}

struct QuickHabitTrackerWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.isDone == true ? "True" : "False")
            Button("Toggle Habit Status", intent: ChangeHabitStatusIntent())
                .onTapGesture {
                    
                    DispatchQueue.main.async {
                        WidgetCenter.shared.reloadAllTimelines()
                    }
                }
            
            Button("Get Habit Status", intent: getHabitStatusIntent())
        
        }
        .buttonStyle(.bordered)
        .containerBackground(.background, for: .widget)
    }
   
}
    
    
    struct QuickHabitTrackerWidget: Widget {
        let kind: String = "QuickHabitTrackerWidget"
        
        var families: [WidgetFamily] {
            
            return [.systemSmall, .systemMedium]

        }
        
        var body: some WidgetConfiguration {
            StaticConfiguration(kind: kind, provider: Provider()) { entry in
                if #available(iOS 17.0, *) {
                    QuickHabitTrackerWidgetEntryView(entry: entry)
                        .containerBackground(.fill.tertiary, for: .widget)
                } else {
                    QuickHabitTrackerWidgetEntryView(entry: entry)
                        .padding()
                        .background()
                }
            }
            .supportedFamilies(families)
            .configurationDisplayName("My Widget")
            .description("This is an example widget.")
        }
    }
    



