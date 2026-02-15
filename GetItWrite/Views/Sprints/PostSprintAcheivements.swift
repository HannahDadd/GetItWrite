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
            VStack(spacing: 8) {
                Text("Congrats! You wrote \(wordsWritten)")
                    .font(Font.custom("AbrilFatface-Regular", size: 34))
                StreakCTA()
                if !badgesEarnt.isEmpty {
                    Divider()
                    Text("Badges Earnt")
                        .font(Font.custom("Bellefair-Regular", size: 18))
                    List {
                        ForEach(badgesEarnt, id: \.self) { badge in
                            BadgePromo(badge: badge)
                        }
                    }
                }
                if let project = project {
                    Text("Selected project:")
                        .font(.headline)
                    WIPView(w: project)
                    GraphForWIP(wip: project)
                }
                StretchedButton(text: "Back To Home Page", action: {
                    action()
                })
            }
            .padding()
        }
    }
}
