//
//  SprintPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 09/01/2026.
//

import SwiftUI

struct SprintPage: View {
    @StateObject private var navigationManager = NavigationManager<SprintPageRoute>()
    @State var path = NavigationPath([
        SprintPageRoute.loading,
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
                    VStack(spacing: 20) {
                        GroupSprintCTA(action: {
                            navigationManager.navigate(to: .loading)
                        }, startSprintAction: {
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
                    }
                }
                .scrollIndicators(.hidden)
            }
            .navigationDestination(for: SprintPageRoute.self) { route in
                switch route {
                case .loading:
                    SprintLoadingPage(endState: {
                        navigationManager.navigate(to: .sprintTwentyMins)
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

enum SprintPageRoute {
    case sprintTwentyMins
    case sprintFortyMins
    case sprintOneHr
    case loading
}
