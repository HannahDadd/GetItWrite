//
//  OnboardingStack.swift
//  Get It Write
//
//  Created by Hannah Dadd on 01/02/2026.
//

import SwiftUI

struct OnboardingStack: View {
    @State private var path = [OnboardingRoute]()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                OnboardingPageOne(nextPage: {
                    path.append(.onboardingPageTwo)
                })
                .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(for: OnboardingRoute.self) { route in
                switch route {
                case .onboardingPageTwo:
                    OnboardingPageTwo(nextPage: {
                        path.append(.onboardingPageThree)
                    })
                    .navigationBarBackButtonHidden(true)
                case .onboardingPageThree:
                    OnboardingPageThree(nextPage: {
                        path.append(.mainPage)
                    })
                    .navigationBarBackButtonHidden(true)
                case .mainPage:
                    MainPage()
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

enum OnboardingRoute {
    case onboardingPageTwo
    case onboardingPageThree
    case mainPage
}
