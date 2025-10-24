//
//  StreakCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 22/10/2025.
//

import SwiftUI

struct StreakCTA: View {
    @AppStorage(UserDefaultNames.streak.rawValue) private var streakEndDate = Date()
    @AppStorage(UserDefaultNames.streak.rawValue) private var streakStartDate = Date()
    var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Spacer()
                Text("\(getStreak())")
                    .font(Font.custom("AbrilFatface-Regular", size: 44))
                    .padding()
                    .foregroundColor(.onPrimary)
                    .background(.primary)
                    .clipShape(Capsule())
                Spacer()
            }
            Text("Already worked on your writing today and want to extend your streak?")
            StretchedButton(text: "Tell me about it", action: action)
        }
    }
    
    func getStreak() -> Int {
        if (streakEndDate - streakStartDate) > 0 {
            return Int(streakEndDate - streakStartDate) + 1
        } else {
            return 0
        }
    }
}
