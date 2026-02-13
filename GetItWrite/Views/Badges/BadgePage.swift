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
                .padding()
            List {
                Section {
                    BadgePromo(title: "In for the long haul", subtitle: "Complete a 1 hour sprint", imageName: "clock.fill", achevied: false)
                }
                
                Section {
                    BadgePromo(title: "Somewhere in the middle", subtitle: "Complete a 40 minute sprint", imageName: "cup.and.heat.waves.fill", achevied: true)
                }
                
                Section {
                    BadgePromo(title: "Just a quick one", subtitle: "Complete a 20 minute sprint", imageName: "bolt.fill", achevied: true)
                }
                
                Section(header: Text("Other tasks")) {
                    BadgePromo(title: "Writer Fighter", subtitle: "Write 200 words in the app", imageName: "shield.fill", achevied: true)
                    BadgePromo(title: "Writer Fighter", subtitle: "Write 500 words in the app", imageName: "", achevied: true)
                    BadgePromo(title: "Writer Fighter", subtitle: "Write 1000 words in the app", imageName: "", achevied: true)
                    BadgePromo(title: "Writer Fighter", subtitle: "Write 10000 words in the app", imageName: "", achevied: true)
                    BadgePromo(title: "Writer Fighter", subtitle: "Write 20000 words in the app", imageName: "", achevied: true)
                    BadgePromo(title: "Writer Fighter", subtitle: "Write 50000 words in the app", imageName: "", achevied: true)
                }
                
                Section {
                    BadgePromo(title: "Streak freak", subtitle: "Get a 2 day streak", imageName: "eyeglasses", achevied: true)
                    BadgePromo(title: "Streak freak", subtitle: "Get a 7 day streak", imageName: "eyeglasses", achevied: true)
                    BadgePromo(title: "Streak freak", subtitle: "Get a 14 day streak", imageName: "eyeglasses", achevied: true)
                    BadgePromo(title: "Streak freak", subtitle: "Get a 31 day streak", imageName: "eyeglasses", achevied: true)
                    BadgePromo(title: "Streak freak", subtitle: "Get a 100 day streak", imageName: "eyeglasses", achevied: true)
                }
                
                Section {
                    BadgePromo(title: "Word Blaster", subtitle: "Write 250 words in a sprint", imageName: "pencil.and.scribble", achevied: true)
                    BadgePromo(title: "Word Blaster", subtitle: "Write 500 words in a sprint", imageName: "pencil.and.scribble", achevied: true)
                    BadgePromo(title: "Word Blaster", subtitle: "Write 1000 words in a sprint", imageName: "pencil.and.scribble", achevied: true)
                    BadgePromo(title: "Word Blaster", subtitle: "Write 2000 words in a sprint", imageName: "pencil.and.scribble", achevied: true)
                    BadgePromo(title: "Word Blaster", subtitle: "Write 5000 words in a sprint", imageName: "pencil.and.scribble", achevied: true)
                }
            }
            .listStyle(.insetGrouped)
        }
    }
}
