//
//  OpeningPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 02/02/2026.
//

import SwiftUI

struct OpeningPage: View {
    var wips: [WIP] = []
    
    init() {
        if let data = UserDefaults.standard.data(forKey: UserDefaultNames.wips.rawValue) {
            if let decoded = try? JSONDecoder().decode([WIP].self, from: data) {
                wips = decoded
            }
        }
    }
    
    var body: some View {
        if wips.isEmpty {
            OnboardingStack()
        } else {
            MainPage(wips: wips)
        }
    }
}
