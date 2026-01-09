//
//  ThirdPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 20/10/2025.
//

import SwiftUI

struct GamesPage: View {
    @StateObject private var navigationManager = GamesPageNavigationManager()
    @State var path = NavigationPath([GamesPageRoute.vocabGame])
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            ScrollViewReader { value in
                VStack {
                    VocabCTA(action: {
                        navigationManager.navigate(to: .vocabGame)
                    })
                    PromptsCTA()
                }.padding()
            }
            .navigationDestination(for: GamesPageRoute.self) { route in
                switch route {
                case .vocabGame:
                    VocabGame(action: {
                        navigationManager.reset()
                    })
                }
            }
        }
    }
}

enum GamesPageRoute {
    case vocabGame
}

final class GamesPageNavigationManager: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigate(to route: GamesPageRoute) {
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
