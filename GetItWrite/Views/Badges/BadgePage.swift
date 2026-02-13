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
                
                Section(header: Text("Word nerd").textCase(.uppercase)) {
                    BadgePromo(title: "Write 200 words in the app", subtitle: "", imageName: "shield.fill", achevied: true)
                    BadgePromo(title: "Write 500 words in the app", subtitle: "", imageName: "shield.fill", achevied: true)
                    BadgePromo(title: "Write 1000 words in the app", subtitle: "", imageName: "shield.fill", achevied: true)
                    BadgePromo(title: "Write 10,000 words in the app", subtitle: "", imageName: "shield.fill", achevied: true)
                    BadgePromo(title: "Write 20,000 words in the app", subtitle: "", imageName: "shield.fill", achevied: true)
                    BadgePromo(title: "Write 50,000 words in the app", subtitle: "", imageName: "shield.fill", achevied: true)
                }
                
                Section(header: Text("streak freak").textCase(.uppercase)) {
                    BadgePromo(title: "Get a 2 day streak", subtitle: "", imageName: "eyeglasses", achevied: true)
                    BadgePromo(title: "Get a 7 day streak", subtitle: "", imageName: "eyeglasses", achevied: true)
                    BadgePromo(title: "Get a 14 day streak", subtitle: "", imageName: "eyeglasses", achevied: true)
                    BadgePromo(title: "Get a 31 day streak", subtitle: "", imageName: "eyeglasses", achevied: true)
                    BadgePromo(title: "Get a 100 day streak", subtitle: "", imageName: "eyeglasses", achevied: true)
                }
                
                Section(header: Text("quick words").textCase(.uppercase)) {
                    BadgePromo(title: "Write 250 words in a sprint", subtitle: "", imageName: "pencil.and.scribble", achevied: true)
                    BadgePromo(title: "Write 500 words in a sprint", subtitle: "", imageName: "pencil.and.scribble", achevied: true)
                    BadgePromo(title: "Write 1,000 words in a sprint", subtitle: "", imageName: "pencil.and.scribble", achevied: true)
                    BadgePromo(title: "Write 2,000 words in a sprint", subtitle: "", imageName: "pencil.and.scribble", achevied: true)
                    BadgePromo(title: "Write 5,000 words in a sprint", subtitle: "", imageName: "pencil.and.scribble", achevied: true)
                }
            }
            .listStyle(.insetGrouped)
        }
    }
}
