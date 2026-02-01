//
//  PageOne.swift
//  Get It Write
//
//  Created by Hannah Dadd on 26/01/2026.
//

import SwiftUI

struct OnboardingPageOne: View {
    let nextPage: () -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            NewWIP(wips: [], action: {_ in
                nextPage()
            }, text: "Tell us about your manuscript")
        }
        .padding()
    }
}
