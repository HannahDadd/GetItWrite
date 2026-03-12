//
//  WritingWidgets.swift
//  WritingWidgets
//
//  Created by Hannah Dadd on 11/03/2026.
//

import SwiftUI
import WidgetKit

struct WritingWidgetsEntryView: View {
    let entry: GetItWriteEntry
    
    @Environment(\.widgetFamily) private var family
    
    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(entry: entry)
        case .systemMedium:
            MediumWidgetView(entry: entry)
        case .systemLarge, .systemExtraLarge:
            LargeWidgetView(entry: entry)
        case .accessoryCircular:
            if let wip = entry.wips.first {
                Gauge(value: Double(wip.count), in: 0.0...Double(wip.goal)) {
                    Text(verbatim: wip.title)
                }
                .gaugeStyle(.accessoryCircularCapacity)
            } else {
                Text("Create a writing project to see your progress here!")
            }
        case .accessoryInline:
            if let wip = entry.wips.first {
                Text(verbatim: "\(wip.count) words out of \(wip.goal)")
            } else {
                Text(verbatim: "Create a writing project")
            }
        case .accessoryRectangular:
            if let wip = entry.wips.first {
                ProgressView(value: Double(wip.count) / Double(wip.goal)) {
                    Text(wip.title)
                        .font(Font.custom("Bellefair-Regular", size: 22))
                }.tint(.primary)
            } else {
                Text("Create a writing project to see your progress here!")
            }
        default:
            EmptyView()
        }
    }
}

struct WritingWidgets: Widget {
    let kind: String = "WritingWidgets"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                WritingWidgetsEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                WritingWidgetsEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
