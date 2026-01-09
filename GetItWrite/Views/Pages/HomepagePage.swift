//
//  Homepage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 20/10/2025.
//

import SwiftUI

struct HomepagePage: View {
    @StateObject private var navigationManager = NavigationManager()
    @State var path = NavigationPath([HomepageRoute.sprint])
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            ScrollViewReader { value in
                VStack {
                    HeadlineAndSubtitle(title: "Celebrate your Wins", subtitle: "Writing games to keep you on top form.")
                    ScrollView(.horizontal) {
                        HStack {
                            Button("Sprint!") {
                                value.scrollTo(0)
                            }
                            .padding()
                            .foregroundColor(.onPrimary)
                            .background(.primary)
                            .clipShape(Capsule())
                            Button("Writing Schedule") {
                                value.scrollTo(1)
                            }
                            .padding()
                            .foregroundColor(.onPrimary)
                            .background(.primary)
                            .clipShape(Capsule())
                            Button("Your WIPs") {
                                value.scrollTo(2)
                            }
                            .padding()
                            .foregroundColor(.onPrimary)
                            .background(.primary)
                            .clipShape(Capsule())
                            Button("Graphs") {
                                value.scrollTo(3)
                            }
                            .padding()
                            .foregroundColor(.onPrimary)
                            .background(.primary)
                            .clipShape(Capsule())
                        }.padding()
                    }
                    ScrollView {
                        VStack(spacing: 20) {
                            SprintCTA(action: {
                                navigationManager.navigate(to: .sprint)
                            })
                            .id(0)
                            Divider()
                            CommitmentCTA()
                                .id(1)
                            Divider()
                            WIPsCTA()
                                .id(2)
                            GraphForWriter()
                                .id(3)
                        }
                        .padding()
                    }
                    .scrollIndicators(.hidden)
                }
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

final class NavigationManager: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigate(to route: HomepageRoute) {
        path.append(route)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func reset() {
        path = NavigationPath()
    }
}
