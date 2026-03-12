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
        let entry = GetItWriteEntry(date: Date(), wips: [WIP(id: UUID().hashValue, title: "The Dragon and the Pen", count: 27000, goal: 80000)])
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
            let entry = GetItWriteEntry(date: Date(), wips: [WIP(id: UUID().hashValue, title: "The Dragon and the Pen", count: 27000, goal: 80000)])
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
