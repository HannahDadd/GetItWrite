//
//  OpeningPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 02/02/2026.
//

import SwiftUI

struct OpeningPage: View {
    @State var wips: [WIP] = []
    @State var onBoardingSequenceFinished = false
    
    var body: some View {
        VStack {
            if wips.isEmpty && !onBoardingSequenceFinished {
                OnboardingStack(wips: $wips, onBoardingSequenceFinished: $onBoardingSequenceFinished)
            } else {
                MainPage(wips: wips)
            }
        }
        .onAppear {
            if let data = UserDefaults.standard.data(forKey: UserDefaultNames.wips.rawValue) {
                if let decoded = try? JSONDecoder().decode([WIP].self, from: data) {
                    wips = decoded
                    onBoardingSequenceFinished = !decoded.isEmpty
                }
            }
        }
    }
}
