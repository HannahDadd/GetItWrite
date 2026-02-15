//
//  PostSprintAcheivements.swift
//  Get It Write
//
//  Created by Hannah Dadd on 15/02/2026.
//

import SwiftUI

struct PostSprintAcheivementsPage: View {
    let badgesEarnt: [Badges]
    let wordsWritten: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Divider()
            Text("Congrats! You wrote \(wordsWritten)")
                .font(Font.custom("AbrilFatface-Regular", size: 34))
            StreakCTA()
            Divider()
            Text("Badges Earnt")
                .font(Font.custom("Bellefair-Regular", size: 18))
            ForEach(badgesEarnt, id: \.self) { badges in
                BadgePromo(title: <#T##String#>, imageName: <#T##String#>, userDefaultName: <#T##String#>)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.secondary))
    }
}
