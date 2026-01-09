//
//  SprintLoadingPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 09/01/2026.
//

import SwiftUI

struct SprintLoadingPage: View {
    let endState: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("Sprint starting in...")
                .font(.title)
                .padding(.bottom, 16)
            CountdownTimer(timeRemaining: 100, endState: {
                endState()
            }, timeRemainingAction: {
                
            })
        }
        .padding()
    }
}
