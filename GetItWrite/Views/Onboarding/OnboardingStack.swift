//
//  OnboardingStack.swift
//  Get It Write
//
//  Created by Hannah Dadd on 01/02/2026.
//

import SwiftUI

struct OnboardingStack: View {
    @State private var path = [OnboardingRoute]()
    @Binding var wips: [WIP]
    @Binding var onBoardingSequenceFinished: Bool
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                OnboardingPageOne(nextPage: { w in
                    wips.append(contentsOf: w)
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
                        onBoardingSequenceFinished = true
                    })
                    .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

enum OnboardingRoute {
    case onboardingPageTwo
    case onboardingPageThree
}
