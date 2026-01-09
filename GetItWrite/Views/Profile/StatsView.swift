//
//  StatsView.swift
//  Get It Write
//
//  Created by Hannah Dadd on 04/09/2024.
//

import SwiftUI
import Firebase

struct StatsView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            if let lastCritique = user.lastCritique {
                Text("Last Critiqued: \(formatDate(timestamp: lastCritique))")
                    .font(.title3)
            }
            if let frequencey = user.frequencey {
                Text("Average time between critiques:  \(Int(frequencey).convertDurationToString())")
                    .font(.headline)
            }
        }.padding()
    }
    
    func formatDate(timestamp: Timestamp) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: timestamp.dateValue(), relativeTo: Date())
    }
}

extension Int {
    
    public func hmsFrom() -> (Int, Int, Int) {
        return (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
    }
    
    public func convertDurationToString() -> String {
        var duration = ""
        let (hour, minute, second) = self.hmsFrom()
        if (hour > 0) {
            duration = self.getHour(hour: hour)
        }
        return "\(duration)\(self.getMinute(minute: minute))\(self.getSecond(second: second))"
    }
    
    private func getHour(hour: Int) -> String {
        var duration = "\(hour) hours, "
        if (hour < 10) {
            duration = "0\(hour) hours, "
        }
        return duration
    }
    
    private func getMinute(minute: Int) -> String {
        if (minute == 0) {
            return "00:"
        }

        if (minute < 10) {
            return "0\(minute) minutes, "
        }

        return "\(minute) minutes, "
    }
    
    private func getSecond(second: Int) -> String {
        if (second == 0){
            return "00"
        }

        if (second < 10) {
            return "0\(second) seconds"
        }
        return "\(second) seconds"
    }
}
