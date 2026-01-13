//
//  Homepage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 20/10/2025.
//

import SwiftUI

struct HomepagePage: View {
    @StateObject private var navigationManager = NavigationManager<HomepageRoute>()
    @State var path = NavigationPath([HomepageRoute.streak])
    
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
                        SoloSprintCTA(action: { sprintDuration in
                            switch sprintDuration {
                            case .twentyMins:
                                navigationManager.navigate(to: .sprintTwentyMins)
                            case .fortyMins:
                                navigationManager.navigate(to: .sprintFortyMins)
                            case .oneHr:
                                navigationManager.navigate(to: .sprintOneHr)
                            }
                        })
                        WordoftheDayCard()
                    }
                    .padding()
                }
                .scrollIndicators(.hidden)
            }
            .navigationDestination(for: HomepageRoute.self) { route in
                switch route {
                case .streak:
                    ExtendStreak(action: {
                        navigationManager.reset()
                    })
                case .sprintTwentyMins:
                    SprintStack(action: {
                        navigationManager.reset()
                    })
                case .sprintFortyMins:
                    SprintStack(action: {
                        navigationManager.reset()
                    })
                case .sprintOneHr:
                    SprintStack(action: {
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

enum HomepageRoute {
    case sprintTwentyMins
    case sprintFortyMins
    case sprintOneHr
    case streak
}
