//
//  SprintLiveActivity.swift
//  SprintLiveActivity
//
//  Created by Hannah Dadd on 11/03/2026.
//

import WidgetKit
import SwiftUI

struct SprintingTimeActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SprintLiveActivityAttributes.self) { context in
            // Lock screen/banner UI
            LiveActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI
                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: "pencil.and.scribble")
                        .padding()
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    Text(timeString(from: context.state.elapsedTime))
                        .fixedSize(horizontal: true, vertical: true)
                        .padding()
                        
                        
                }
                
                DynamicIslandExpandedRegion(.center) {
                    VStack(){
                        Spacer()
                        Text(context.state.statusMessage)
                            .fixedSize(horizontal: true, vertical: true)
                            .bold()
                            .padding(.vertical)
                        Gauge(value: context.state.progress) {
                            Text("pencil.and.scribble")
                        } currentValueLabel: {
                            Text("\(Int(context.state.progress * 100))%")
                        }
                        .gaugeStyle(.accessoryLinear)
                        .padding(.vertical, 24)
                    }
                }
            } compactLeading: {
                Image(systemName: "pencil.and.scribble")
                    
            } compactTrailing: {
                Text("\(Int(context.state.progress * 100))%")
                    
            } minimal: {
                Image(systemName: "pencil.and.scribble")
                    
            }
        }
    }
    
    private func timeString(from seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
