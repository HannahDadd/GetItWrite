//
//  SprintLiveActivityLiveActivity.swift
//  SprintLiveActivity
//
//  Created by Hannah Dadd on 20/02/2026.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct SprintLiveActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct SprintLiveActivityLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SprintLiveActivityAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension SprintLiveActivityAttributes {
    fileprivate static var preview: SprintLiveActivityAttributes {
        SprintLiveActivityAttributes(name: "World")
    }
}

extension SprintLiveActivityAttributes.ContentState {
    fileprivate static var smiley: SprintLiveActivityAttributes.ContentState {
        SprintLiveActivityAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: SprintLiveActivityAttributes.ContentState {
         SprintLiveActivityAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: SprintLiveActivityAttributes.preview) {
   SprintLiveActivityLiveActivity()
} contentStates: {
    SprintLiveActivityAttributes.ContentState.smiley
    SprintLiveActivityAttributes.ContentState.starEyes
}
