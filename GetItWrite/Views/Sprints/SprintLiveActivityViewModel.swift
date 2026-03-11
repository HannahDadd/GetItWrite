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
    var bookName: String
    let duration: TimeInterval
    var progress: Double = 0
    var sprintActivity: Activity<SprintLiveActivityAttributes>? = nil
    var elapsedTime: TimeInterval = 0
    
    init(bookName: String, duration: TimeInterval) {
        self.bookName = bookName
        self.duration = duration
    }
    
    func startLiveActivity() {
        let attributes = SprintLiveActivityAttributes(
            bookName: bookName,
            duration: duration
        )
        
        let initialState = SprintLiveActivityAttributes.ContentState(
            progress: 0.0,
            elapsedTime: 0,
            statusMessage: "Get those words written"
        )
        
        do {
            sprintActivity = try Activity.request(attributes: attributes, content: ActivityContent(state: initialState, staleDate: nil))
        } catch {
            print("Error starting live activity: \(error)")
        }
    }

    func updateLiveActivity() {
        let statusMessage = "Get those words written"
        
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
