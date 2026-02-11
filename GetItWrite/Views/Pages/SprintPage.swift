//
//  SprintPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 09/01/2026.
//

import SwiftUI

struct SprintPage: View {
    @StateObject var networking = SprintNetworking()
    @StateObject private var navigationManager = NavigationManager<SprintPageRoute>()
    @State var path = NavigationPath([
        SprintPageRoute.sprintGroup,
        SprintPageRoute.sprintTwentyMins,
        SprintPageRoute.sprintFortyMins,
        SprintPageRoute.sprintOneHr
    ])
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            VStack(alignment: .leading) {
                ScrollView {
                    HeadlineAndSubtitle(title: "Writing Sprints", subtitle: "Let's get those words written.")
                        .padding()
                    VStack(spacing: 34) {
                        GroupSprintCTA(action: {
                            navigationManager.navigate(to: .sprintTwentyMins)
                        })
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
                        LeaderboardCTA()
                    }
                }
                .scrollIndicators(.hidden)
            }
            .navigationDestination(for: SprintPageRoute.self) { route in
                switch route {
                case .sprintTwentyMins:
                    SprintStack(action: {
                        navigationManager.reset()
                    })
                    .environmentObject(networking)
                case .sprintFortyMins:
                    SprintStack(action: {
                        navigationManager.reset()
                    })
                    .environmentObject(networking)
                case .sprintOneHr:
                    SprintStack(action: {
                        navigationManager.reset()
                    })
                    .environmentObject(networking)
                case .sprintGroup:
                    SprintStack(action: {
                        navigationManager.reset()
                    }, waitingTime: Int((networking.sprint?.timestamp.dateValue().timeIntervalSince1970 ?? 0) - Date.now.timeIntervalSince1970))
                    .environmentObject(networking)
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
            .environmentObject(networking)
        }
    }
}

enum SprintPageRoute {
    case sprintGroup
    case sprintTwentyMins
    case sprintFortyMins
    case sprintOneHr
}
