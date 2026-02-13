//
//  LeaderboardPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 24/01/2026.
//

import SwiftUI

struct BadgePage: View {
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("speed run").textCase(.uppercase)) {
                    BadgePromo(title: "Complete a 20 minute sprint", imageName: "bolt.fill", achevied: true)
                }
                
                Section(header: Text("Somewhere in the middle").textCase(.uppercase)) {
                    BadgePromo(title: "Complete a 40 minute sprint", imageName: "cup.and.heat.waves.fill", achevied: true)
                }
                
                Section(header: Text("In for the long haul").textCase(.uppercase)) {
                    BadgePromo(title: "Complete a 1 hour sprint", imageName: "clock.fill", achevied: false)
                }
                
                Section(header: Text("Word nerd").textCase(.uppercase)) {
                    BadgePromo(title: "Write 200 words in the app", imageName: "shield.fill", achevied: true)
                    BadgePromo(title: "Write 500 words in the app", imageName: "shield.fill", achevied: false)
                    BadgePromo(title: "Write 1000 words in the app", imageName: "shield.fill", achevied: false)
                    BadgePromo(title: "Write 10,000 words in the app", imageName: "shield.fill", achevied: false)
                    BadgePromo(title: "Write 20,000 words in the app", imageName: "shield.fill", achevied: false)
                    BadgePromo(title: "Write 50,000 words in the app", imageName: "shield.fill", achevied: false)
                }
                
                Section(header: Text("streak freak").textCase(.uppercase)) {
                    BadgePromo(title: "Get a 2 day streak", imageName: "eyeglasses", achevied: true)
                    BadgePromo(title: "Get a 7 day streak", imageName: "eyeglasses", achevied: true)
                    BadgePromo(title: "Get a 14 day streak", imageName: "eyeglasses", achevied: true)
                    BadgePromo(title: "Get a 31 day streak", imageName: "eyeglasses", achevied: true)
                    BadgePromo(title: "Get a 100 day streak", imageName: "eyeglasses", achevied: true)
                }
                
                Section(header: Text("quick words").textCase(.uppercase)) {
                    BadgePromo(title: "Write 250 words in a sprint", imageName: "pencil.and.scribble", achevied: true)
                    BadgePromo(title: "Write 500 words in a sprint", imageName: "pencil.and.scribble", achevied: true)
                    BadgePromo(title: "Write 1,000 words in a sprint", imageName: "pencil.and.scribble", achevied: true)
                    BadgePromo(title: "Write 2,000 words in a sprint", imageName: "pencil.and.scribble", achevied: true)
                    BadgePromo(title: "Write 5,000 words in a sprint", imageName: "pencil.and.scribble", achevied: true)
                }
            }
            .listStyle(.insetGrouped)
            .navigationBarTitle("Achievements")
        }
}
