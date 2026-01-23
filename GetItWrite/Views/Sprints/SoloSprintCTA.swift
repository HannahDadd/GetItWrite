//
//  RunningSprintCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 09/01/2026.
//

import SwiftUI

struct SoloSprintCTA: View {
    var action: (SprintDurations) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Start a solo writing sprint")
                .textCase(.uppercase)
                .padding(.horizontal)
            ScrollView(.horizontal) {
                HStack {
                    StartSprintCard(action: { action(.twentyMins) }, text: "20 mins")
                    StartSprintCard(action: { action(.fortyMins) }, text: "40 mins")
                    StartSprintCard(action: { action(.oneHr) }, text: "1 hour")
                }
                .padding(.horizontal)
            }
        }
    }
}

enum SprintDurations {
    case twentyMins
    case fortyMins
    case oneHr
}
