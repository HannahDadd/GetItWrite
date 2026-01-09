//
//  SprintPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 09/01/2026.
//

import SwiftUI

struct SprintPage: View {
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            VStack(alignment: .leading) {
                ScrollView {
                    HeadlineAndSubtitle(title: "Hey, future best selling author", subtitle: "Let's get that manuscript written.")
                    VStack(spacing: 20) {
                        StreakCTA(action: {
                            navigationManager.navigate(to: .streak)
                        })
                        CommitmentCTA()
                        SprintCTA(action: {
                            navigationManager.navigate(to: .sprint)
                        })
                        WordoftheDayCard()
                    }
                    .padding()
                }
                .scrollIndicators(.hidden)
            }
            .navigationDestination(for: HomepageRoute.self) { route in
                switch route {
                case .sprint:
                    SprintStack(action: {
                        navigationManager.reset()
                    })
                case .streak:
                    ExtendStreak(action: {
                        navigationManager.reset()
                    })
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
        }
    }
}
