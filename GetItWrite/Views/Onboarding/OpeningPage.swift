//
//  OpeningPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 02/02/2026.
//

import SwiftUI

struct OpeningPage: View {
    var wip: WIP? = nil
    
    init() {
        if let data = UserDefaults.standard.data(forKey: UserDefaultNames.wips.rawValue) {
            if let decoded = try? JSONDecoder().decode([WIP].self, from: data) {
                wip = decoded.first
            }
        }
    }
    
    var body: some View {
        if wip != nil {
            MainPage()
                .navigationBarBackButtonHidden(true)
        } else {
            OnboardingStack()
        }
    }
}
