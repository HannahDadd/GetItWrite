//
//  MainPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 08/08/2025.
//

import SwiftUI

struct MainPage: View {
    @StateObject private var navigationManager = NavigationManager()
    @State var path = NavigationPath([AppRoute.sprint])
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            ScrollViewReader { value in
                VStack {
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
                        }
                        .padding()
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .navigationTitle("Get It Write")
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .sprint:
                    SprintStack(action: {
                        navigationManager.reset()
                    })
                }
            }
        }
        .accentColor(.primary)
    }
}

enum AppRoute {
    case sprint
}

final class NavigationManager: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigate(to route: AppRoute) {
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
