//
//  RunningSprintCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 09/01/2026.
//

import SwiftUI

struct RunningSprintCTA: View {
    var action: (Int) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Start a community sprint")
                .textCase(.uppercase)
                .padding(.horizontal)
            ScrollView(.horizontal) {
                HStack {
                    StartSprintCard(action: { action(1200) }, text: "20 mins")
                    StartSprintCard(action: { action(2400) }, text: "40 mins")
                    StartSprintCard(action: { action(3600) }, text: "1 hour")
                }
                .padding()
            }
        }
    }
}
