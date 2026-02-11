//
//  SprintLoadingPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 09/01/2026.
//

import SwiftUI

struct SprintLoadingPage: View {
    @EnvironmentObject var networking: SprintNetworking
    let endState: () -> Void
    let waitingTime: Int
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Grab a cuppa, stretch, & get hyped. The sprint starts in")
                .foregroundColor(Color.white)
                .padding(.bottom, 16)
            CountdownTimer(timeRemaining: waitingTime, endState: {
                endState()
            }, textSize: 120, timeRemainingAction: {})
            Text("Sprint Participants:")
                .foregroundColor(Color.white)
                .padding(.bottom, 16)
            TagCloud(tags: networking.sprint?.participants.keys.compactMap { $0 } ?? [], chosenTags: .constant([]), singleTagView: false)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.secondary))
    }
}
