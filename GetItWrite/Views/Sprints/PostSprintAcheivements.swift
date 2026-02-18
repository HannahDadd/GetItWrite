//
//  PostSprintAcheivements.swift
//  Get It Write
//
//  Created by Hannah Dadd on 15/02/2026.
//

import SwiftUI

struct PostSprintAcheivementsPage: View {
    var project: WIP?
    var wordsWritten: Int
    let badgesEarnt: [Badge]
    let action: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Congrats!")
                    .font(Font.custom("AbrilFatface-Regular", size: 34))
                Text("You wrote \(wordsWritten) words")
                    .font(Font.custom("Bellefair-Regular", size: 18))
                StreakCTA()
                Divider()
                if let project = project {
                    WIPView(w: project)
                }
                if !badgesEarnt.isEmpty {
                    Text("Badges Earnt \(badgesEarnt.count)")
                        .font(Font.custom("Bellefair-Regular", size: 18))
                    ForEach(badgesEarnt, id: \.self) { badge in
                        BadgePromo(badge: badge)
                    }
                }
                StretchedButton(text: "Done", action: {
                    action()
                })
            }
            .padding()
        }
    }
}
