//
//  SprintLiveActivityAttributes.swift
//  Get It Write
//
//  Created by Hannah Dadd on 24/02/2026.
//

import ActivityKit
import Foundation

struct PrintingAttributes: ActivityAttributes {
    
    public struct ContentState: Codable, Hashable {
        var progress: Double
        var elapsedTime: TimeInterval
        var statusMessage: String
    }
    
    var printName: String
    var estimatedDuration: TimeInterval
}
