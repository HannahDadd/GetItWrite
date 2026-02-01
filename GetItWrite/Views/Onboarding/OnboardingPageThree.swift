//
//  OnboardingPageThree.swift
//  Get It Write
//
//  Created by Hannah Dadd on 26/01/2026.
//

import SwiftUI

struct OnboardingPageThree: View {
    @AppStorage(UserDefaultNames.notification.rawValue) private var notif = false
    @State var time = Date()
    
    let nextPage: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Text("We're pretty chuffed you're here!")
                .font(Font.custom("AbrilFatface-Regular", size: 34))
                .padding(.bottom, 16)
                .multilineTextAlignment(.center)
            Spacer()
            HStack {
                Image(systemName: "clock.fill")
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { size, axis in
                        size * 0.2
                    }
                Spacer()
                Text("Try a writing sprint")
                    .font(Font.custom("Bellefair-Regular", size: 22))
            }
            Spacer()
            HStack {
                Text("Join the leaderboard")
                    .font(Font.custom("Bellefair-Regular", size: 22))
                Spacer()
                Image(systemName: "person.3.fill")
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { size, axis in
                        size * 0.2
                    }
            }
            Spacer()
            HStack {
                Image(systemName: "chart.xyaxis.line")
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { size, axis in
                        size * 0.2
                    }
                Spacer()
                Text("Track your writing")
                    .font(Font.custom("Bellefair-Regular", size: 22))
            }
            Spacer()
            StretchedButton(text: "Let's goooo", action: {
                nextPage()
            })
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
