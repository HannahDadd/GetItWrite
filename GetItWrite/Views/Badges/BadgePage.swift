//
//  LeaderboardPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 24/01/2026.
//

import SwiftUI

struct BadgePage: View {
    
    var body: some View {
        GeometryReader { geo in
            List {
                Text("Achievements")
                    .font(Font.custom("AbrilFatface-Regular", size: 34))
                    .listRowBackground(Color.clear)
                
                Section(header: Text("finish a book").textCase(.uppercase)) {
                    FinishBookPromo(badge: Badge.bookGoal)
                }
                .listRowBackground(Color.CardPurple)
                
                Section(header: Text("sprints completed").textCase(.uppercase)) {
                    HStack {
                        SprintBadge(badge: Badge.twentySprint, width: geo.size.width * 0.29)
                        Spacer()
                        SprintBadge(badge: Badge.fortySprint, width: geo.size.width * 0.29)
                        Spacer()
                        SprintBadge(badge: Badge.hourSprint, width: geo.size.width * 0.29)
                    }
                }
                .listRowBackground(Color.clear)
                
                Section(header: Text("quick words").textCase(.uppercase)) {
                    BadgePromo(badge: Badge.quickWords250)
                    BadgePromo(badge: Badge.quickWords500)
                    BadgePromo(badge: Badge.quickWords1000)
                    BadgePromo(badge: Badge.quickWords2000)
                    BadgePromo(badge: Badge.quickWords5000)
                }
                
                Section(header: Text("Word nerd").textCase(.uppercase)) {
                    BadgePromo(badge: Badge.wordNerd200)
                    BadgePromo(badge: Badge.wordNerd500)
                    BadgePromo(badge: Badge.wordNerd1000)
                    BadgePromo(badge: Badge.wordNerd10000)
                    BadgePromo(badge: Badge.wordNerd20000)
                    BadgePromo(badge: Badge.wordNerd50000)
                }
                
                Section(header: Text("streak freak").textCase(.uppercase)) {
                    BadgePromo(badge: Badge.streakFreak2)
                    BadgePromo(badge: Badge.streakFreak7)
                    BadgePromo(badge: Badge.streakFreak14)
                    BadgePromo(badge: Badge.streakFreak31)
                    BadgePromo(badge: Badge.streakFreak100)
                }
            }
            .listStyle(.insetGrouped)
            .navigationSplitViewStyle(.prominentDetail)
        }
    }
}
