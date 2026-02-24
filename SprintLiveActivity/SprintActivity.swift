//
//  SprintActivity.swift
//  Get It Write
//
//  Created by Hannah Dadd on 24/02/2026.
//

import SwiftUI
import WidgetKit
import ActivityKit

struct PrintingTimeActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PrintingAttributes.self) { context in
            // Lock screen/banner UI
            LiveActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI
                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: "printer.fill")
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
                            Text("Progress")
                        } currentValueLabel: {
                            Text("\(Int(context.state.progress * 100))%")
                        }
                        .gaugeStyle(.accessoryLinear)
                        .padding(.vertical, 24)
                    }
                }
            } compactLeading: {
                Image(systemName: "printer.fill")
                    
            } compactTrailing: {
                Text("\(Int(context.state.progress * 100))%")
                    
            } minimal: {
                Image(systemName: "printer.fill")
                    
            }
        }
    }
    
    private func timeString(from seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct LiveActivityView: View {
    let context: ActivityViewContext<PrintingAttributes>
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "printer.fill")
                    .font(.title2)
                
                VStack(alignment: .leading) {
                    Text("3D Printing")
                        .font(.headline)
                    Text(context.attributes.printName)
                        .font(.subheadline)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(timeString(from: context.state.elapsedTime))
                    Text("/ \(timeString(from: context.attributes.estimatedDuration))")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            
            Gauge(value: context.state.progress) {
                EmptyView()
            } currentValueLabel: {
                Text("\(Int(context.state.progress * 100))%")
            }
            .gaugeStyle(.accessoryLinear)
            .tint(.blue)
            
            Text(context.state.statusMessage)
                .font(.callout)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
    
    private func timeString(from seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
