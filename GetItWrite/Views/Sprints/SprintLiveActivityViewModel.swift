//
//  SprintLiveActivityViewModel.swift
//  Get It Write
//
//  Created by Hannah Dadd on 24/02/2026.
//

import Foundation
import ActivityKit

@Observable
class SprintActivityViewModel {
    var printName = "Benchy Boat"
    let printDuration: TimeInterval = 60
    var progress: Double = 0
    var sprintActivity: Activity<SprintLiveActivityAttributes>? = nil
    var elapsedTime: TimeInterval = 0
    
    func startLiveActivity() {
        let attributes = SprintLiveActivityAttributes(
            printName: printName,
            estimatedDuration: printDuration
        )
        
        let initialState = SprintLiveActivityAttributes.ContentState(
            progress: 0.0,
            elapsedTime: 0,
            statusMessage: "Starting print..."
        )
        
        do {
            sprintActivity = try Activity.request(attributes: attributes, content: ActivityContent(state: initialState, staleDate: nil))
        } catch {
            print("Error starting live activity: \(error)")
        }
    }

    func updateLiveActivity() {
        let statusMessage: String
        
        if progress < 0.3 {
            statusMessage = "Heating bed and extruder..."
        } else if progress < 0.6 {
            statusMessage = "Printing base layers..."
        } else if progress < 0.9 {
            statusMessage = "Printing details..."
        } else {
            statusMessage = "Finishing print..."
        }
        
        let updatedState = SprintLiveActivityAttributes.ContentState(
            progress: progress,
            elapsedTime: elapsedTime,
            statusMessage: statusMessage
        )
        
        Task {
            await sprintActivity?.update(using: updatedState)
        }
    }

    func endLiveActivity(success: Bool = false) {
        let finalMessage = success ? "Print completed successfully!" : "Print canceled"
        
        let finalState = SprintLiveActivityAttributes.ContentState(
            progress: success ? 1.0 : progress,
            elapsedTime: elapsedTime,
            statusMessage: finalMessage
        )
        
        Task {
            await sprintActivity?.end(ActivityContent(state: finalState, staleDate: nil), dismissalPolicy: .default)
        }
    }
}
