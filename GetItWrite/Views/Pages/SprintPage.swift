//
//  SprintPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 09/01/2026.
//

import SwiftUI

struct SprintPage: View {
    @StateObject private var navigationManager = NavigationManager<SprintPageRoute>()
    @State var path = NavigationPath([SprintPageRoute.sprint])
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            VStack(alignment: .leading) {
                ScrollView {
                    HeadlineAndSubtitle(title: "Sprints", subtitle: "Let's get those words written.")
                    VStack(spacing: 20) {
                        RunningSprintCTA(action: {
                            navigationManager.navigate(to: .loading)
                        })
                        SoloSprintCTA(action: {
                            navigationManager.navigate(to: .sprint)
                        })
                    }
                }
                .scrollIndicators(.hidden)
            }
            .navigationDestination(for: SprintPageRoute.self) { route in
                switch route {
                case .sprint:
                    SprintStack(action: {
                        navigationManager.reset()
                    })
                case .loading:
                    SprintLoadingPage(endState: {
                        navigationManager.navigate(to: .sprint)
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
    case sprint
    case loading
}
