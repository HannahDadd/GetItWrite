//
//  Homepage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 20/10/2025.
//

import SwiftUI

struct HomepagePage: View {
    @StateObject private var navigationManager = NavigationManager<HomepageRoute>()
    @State var path = NavigationPath([HomepageRoute.sprint])
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
                VStack {
                    HeadlineAndSubtitle(title: "Celebrate your Wins", subtitle: "Writing games to keep you on top form.")
                    ScrollView {
                        VStack(spacing: 20) {
                            SprintCTA(action: {
                                navigationManager.navigate(to: .sprint)
                            })
                            .id(0)
                            Divider()
                            CommitmentCTA()
                                .id(1)
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
                }
            }
        }
    }
}

enum HomepageRoute {
    case sprint
}
