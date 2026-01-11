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
        VStack(spacing: 30) {
            Text("Grab a cuppa, stretch, & get hyped. The sprint starts in")
                .foregroundColor(Color.white)
                .padding(.bottom, 16)
            CountdownTimer(timeRemaining: 600, endState: {
                endState()
            }, timeRemainingAction: {})
            Text("Sprint Participants:")
                .foregroundColor(Color.white)
                .padding(.bottom, 16)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.secondary))
    }
}
