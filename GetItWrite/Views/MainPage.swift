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
            ScrollView {
                VStack(spacing: 8) {
                    StretchedButton(text: "Start sprint", action: {
                        navigationManager.navigate(to: .sprint)
                    })
                    .padding()
                    CommitmentCTA()
                    WIPsCTA()
                }
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .sprint:
                    SprintStack()
                }
            }
        }
        .environmentObject(navigationManager)
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
