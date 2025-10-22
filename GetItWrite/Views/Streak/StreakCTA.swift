//
//  StreakCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 22/10/2025.
//

import SwiftUI

struct StreakCTA: View {
    @AppStorage(UserDefaultNames.streak.rawValue) private var streak = 0
    var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Spacer()
                Text("\(streak)")
                    .font(Font.custom("AbrilFatface-Regular", size: 44))
                    .padding()
                    .foregroundColor(.onPrimary)
                    .background(.primary)
                    .clipShape(Capsule())
                Spacer()
            }
            Text("Already worked on your writing today?")
            StretchedButton(text: "Tell us About it", action: action)
        }
    }
}
