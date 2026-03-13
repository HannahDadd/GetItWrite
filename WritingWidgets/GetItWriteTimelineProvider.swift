//
//  GetItWriteTimelineProvider.swift
//  Get It Write
//
//  Created by Hannah Dadd on 11/03/2026.
//

import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> GetItWriteEntry {
        GetItWriteEntry(date: Date(), wips: [])
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (GetItWriteEntry) -> Void
    ) {
        let entry = GetItWriteEntry(date: Date(), wips: [WIP(id: UUID().hashValue, title: "The Dragon and the Pen", count: 27000, goal: 80000), WIP(id: UUID().hashValue, title: "All the Moments We Never Had", count: 63000, goal: 75000), WIP(id: UUID().hashValue, title: "A Wizard Called Skate", count: 237, goal: 5000), WIP(id: UUID().hashValue, title: "The Day we Fell in Love", count: 34200, goal: 50000)])
        completion(entry)
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<GetItWriteEntry>) -> Void
    ) {
        var entries: [GetItWriteEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0..<5 {
            let entryDate = Calendar.current.date(
                byAdding: .hour,
                value: hourOffset,
                to: currentDate
            )!
            
            if let data = UserDefaults(suiteName: "group.getitwrite")?.data(forKey: "wips") {
                if let decoded = try? JSONDecoder().decode([WIP].self, from: data) {
                    let entry = GetItWriteEntry(date: entryDate, wips: decoded)
                    entries.append(entry)
                }
            }
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
