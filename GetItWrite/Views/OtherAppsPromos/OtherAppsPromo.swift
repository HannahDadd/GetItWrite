//
//  WritingGamesPromo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 17/02/2026.
//

import SwiftUI

struct OtherAppsPromo: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Image("ShelfifyPromo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("Download Shelfify")
                    .font(Font.custom("AbrilFatface-Regular", size: 34))
                    .multilineTextAlignment(.leading)
                Text("""
                Do you want a visual project tracker for your workout?
                
                As your word count climbs, in Shelfify, your once-abandoned library slowly comes back to life, filling with books. Friendly ghosts visit your library with encouraging messages to keep you motivated, while built-in focus sprints help you stay productive. Even when you’re away from the app, widgets and daily notifications help  maintain momentum. Build your library, one writing session at a time.

                Download Shelfify from the App Store today.
                """)
                .font(Font.custom("Bellefair-Regular", size: 18))
                .multilineTextAlignment(.leading)
                HStack {
                    Spacer()
                    StretchedButton(text: "Download now", action: {})
                    Spacer()
                }
                Image("WritingGamesPromo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("Download Writing Games")
                    .font(Font.custom("AbrilFatface-Regular", size: 34))
                    .multilineTextAlignment(.leading)
                Text("""
                Hey, you look like a really hard-working writer. Fancy taking a break and still working on those writing skills?
                
                Writing Games helps you relax and sharpens your writing skills. With games that will teach you fancy new words, practice your editing skills, and daily writing prompts, it's the perfect place for any word nerd to wind down. Whether you want to resolve a conflict or add a zesty new voice to some bland as anything dialogue, Writing Games is the place for you.
                
                Download it from the App Store today- we can’t wait to see your editing skills.
                """)
                .font(Font.custom("Bellefair-Regular", size: 18))
                .multilineTextAlignment(.leading)
                HStack {
                    Spacer()
                    StretchedButton(text: "Download now", action: {})
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
    }
}
