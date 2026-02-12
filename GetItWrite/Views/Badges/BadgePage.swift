//
//  LeaderboardPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 24/01/2026.
//

import SwiftUI

struct BadgePage: View {
    
    var body: some View {
        VStack {
            HeadlineAndSubtitle(title: "Achievements", subtitle: "")
            List {
                BadgePromo(title: "In for the long haul", subtitle: "Complete a 1 hour sprint", imageName: "clock.fill", achevied: true)
                BadgePromo(title: "Somewhere in the middle", subtitle: "Complete a 40 minute sprint", imageName: "cup.and.heat.waves.fill", achevied: true)
                BadgePromo(title: "Just a quick one", subtitle: "Complete a 20 minute sprint", imageName: "bolt.fill", achevied: true)
                BadgePromo(title: "Word Blaster", subtitle: "Write 200 words in a sprint", imageName: "pencil.and.scribble", achevied: true)
                BadgePromo(title: "Writer Fighter", subtitle: "Write 200 words in the app", imageName: "shield.fill", achevied: true)
                BadgePromo(title: "Streak freak", subtitle: "Get a 2 day streak", imageName: "eyeglasses", achevied: true)
            }
            .listStyle(.insetGrouped)
        }
    }
}
