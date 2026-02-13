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
                    BadgePromo(title: "Complete a 20 minute sprint", imageName: "bolt.fill", userDefaultName: UserDefaultNames.twentySprint.rawValue)
                }
                
                Section(header: Text("Somewhere in the middle").textCase(.uppercase)) {
                    BadgePromo(title: "Complete a 40 minute sprint", imageName: "cup.and.heat.waves.fill", userDefaultName: UserDefaultNames.fortySprint.rawValue)
                }
                
                Section(header: Text("In for the long haul").textCase(.uppercase)) {
                    BadgePromo(title: "Complete a 1 hour sprint", imageName: "clock.fill", userDefaultName: UserDefaultNames.hourSprint.rawValue)
                }
                
                Section(header: Text("Word nerd").textCase(.uppercase)) {
                    BadgePromo(title: "Write 200 words in the app", imageName: "shield.fill", userDefaultName: UserDefaultNames.wordNerd200.rawValue)
                    BadgePromo(title: "Write 500 words in the app", imageName: "shield.fill", userDefaultName: UserDefaultNames.wordNerd500.rawValue)
                    BadgePromo(title: "Write 1000 words in the app", imageName: "shield.fill", userDefaultName: UserDefaultNames.wordNerd1000.rawValue)
                    BadgePromo(title: "Write 10,000 words in the app", imageName: "shield.fill", userDefaultName: UserDefaultNames.wordNerd10000.rawValue)
                    BadgePromo(title: "Write 20,000 words in the app", imageName: "shield.fill", userDefaultName: UserDefaultNames.wordNerd20000.rawValue)
                    BadgePromo(title: "Write 50,000 words in the app", imageName: "shield.fill", userDefaultName: UserDefaultNames.wordNerd50000.rawValue)
                }
                
                Section(header: Text("streak freak").textCase(.uppercase)) {
                    BadgePromo(title: "Get a 2 day streak", imageName: "eyeglasses", userDefaultName: UserDefaultNames.streakFreak2.rawValue)
                    BadgePromo(title: "Get a 7 day streak", imageName: "eyeglasses", userDefaultName: UserDefaultNames.streakFreak7.rawValue)
                    BadgePromo(title: "Get a 14 day streak", imageName: "eyeglasses", userDefaultName: UserDefaultNames.streakFreak14.rawValue)
                    BadgePromo(title: "Get a 31 day streak", imageName: "eyeglasses", userDefaultName: UserDefaultNames.streakFreak31.rawValue)
                    BadgePromo(title: "Get a 100 day streak", imageName: "eyeglasses", userDefaultName: UserDefaultNames.streakFreak100.rawValue)
                }
                
                Section(header: Text("quick words").textCase(.uppercase)) {
                    BadgePromo(title: "Write 250 words in a sprint", imageName: "pencil.and.scribble", userDefaultName: UserDefaultNames.quickWords250.rawValue)
                    BadgePromo(title: "Write 500 words in a sprint", imageName: "pencil.and.scribble", userDefaultName: UserDefaultNames.quickWords500.rawValue)
                    BadgePromo(title: "Write 1,000 words in a sprint", imageName: "pencil.and.scribble", userDefaultName: UserDefaultNames.quickWords1000.rawValue)
                    BadgePromo(title: "Write 2,000 words in a sprint", imageName: "pencil.and.scribble", userDefaultName: UserDefaultNames.quickWords2000.rawValue)
                    BadgePromo(title: "Write 5,000 words in a sprint", imageName: "pencil.and.scribble", userDefaultName: UserDefaultNames.quickWords5000.rawValue)
                }
                
                Section(header: Text("write a book").textCase(.uppercase)) {
                    BadgePromo(title: "Hit your book's target word count", imageName: "target", userDefaultName: UserDefaultNames.bookGoal.rawValue)
                }
            }
            .listStyle(.insetGrouped)
            .navigationBarTitle("Achievements")
        }
    }
}
