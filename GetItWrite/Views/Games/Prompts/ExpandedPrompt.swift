//
//  ExpandedPrompt.swift
//  Get It Write
//
//  Created by Hannah Dadd on 24/10/2025.
//

import SwiftUI

struct ExpandedPrompt: View {
    @AppStorage(UserDefaultNames.streak.rawValue) private var streakEndDate = Date()
    @State private var btnPressed = false
    let question: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question)
            Spacer()
            Text(btnPressed ? "" : "Did you do this prompt? Tell us to extend your streak!")
            StretchedButton(text: btnPressed ? "Streak extended!" : "I did the prompt!", action: {
                streakEndDate = Date()
                btnPressed = true
            })
        }.padding()
    }
}
