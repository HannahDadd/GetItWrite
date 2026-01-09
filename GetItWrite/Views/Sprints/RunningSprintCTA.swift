//
//  RunningSprintCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 09/01/2026.
//

import SwiftUI

struct RunningSprintCTA: View {
    var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Start a sprint")
                .textCase(.uppercase)
                .padding(.vertical)
            ScrollView(.horizontal) {
                HStack {
                    StartSprintCard(action: {}, text: "20 mins")
                    StartSprintCard(action: {}, text: "40 mins")
                    StartSprintCard(action: {}, text: "1 hour")
                }
                .padding()
            }
        }
    }
}
