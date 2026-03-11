//
//  LiveActivityView.swift
//  Get It Write
//
//  Created by Hannah Dadd on 11/03/2026.
//

import WidgetKit
import SwiftUI

struct LiveActivityView: View {
    let context: ActivityViewContext<SprintLiveActivityAttributes>
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "printer.fill")
                    .font(.title2)
                
                VStack(alignment: .leading) {
                    Text("3D Printing")
                        .font(.headline)
                    Text(context.attributes.bookName)
                        .font(.subheadline)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(timeString(from: context.state.elapsedTime))
                    Text("/ \(timeString(from: context.attributes.duration))")
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
