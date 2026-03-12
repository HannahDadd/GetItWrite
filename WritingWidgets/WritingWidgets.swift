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
            Gauge(value: Double(entry.wordCount), in: 0.0...Double(entry.targetWordCount)) {
                Text(verbatim: entry.bookname)
            }
            .gaugeStyle(.accessoryCircularCapacity)
        case .accessoryInline:
            Text(verbatim: entry.bookname)
        case .accessoryRectangular:
            ProgressView(value: Double(entry.wordCount) / Double(entry.targetWordCount)) {
                Text("\(entry.bookname)")
                    .font(Font.custom("Bellefair-Regular", size: 22))
            }.tint(.primary)
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
