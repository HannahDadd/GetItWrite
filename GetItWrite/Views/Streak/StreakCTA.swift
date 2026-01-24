//
//  StreakCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 23/01/2026.
//

import SwiftUI

struct StreakCTA: View {
//    @AppStorage(UserDefaultNames.streakStart.rawValue) private var streakStart: Date? = nil
    var action: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                StreakDay(dayInitial: "M", dayComplete: false)
                StreakDay(dayInitial: "T", dayComplete: false)
                StreakDay(dayInitial: "W", dayComplete: false)
                StreakDay(dayInitial: "T", dayComplete: false)
                StreakDay(dayInitial: "F", dayComplete: false)
                StreakDay(dayInitial: "S", dayComplete: false)
                StreakDay(dayInitial: "S", dayComplete: false)
            }
            HStack {
                Spacer()
//                Text("\(streak)")
                    .font(Font.custom("AbrilFatface-Regular", size: 44))
                    .padding()
                    .foregroundColor(.onPrimary)
                    .background(.primary)
                    .clipShape(Capsule())
                Spacer()
            }
            Text("words you've written on the app.")
            GameButton(text: "Add Words to a Project", action: action)
        }
    }
}

struct StreakDay: View {
    let dayInitial: String
    let dayComplete: Bool
    
    var body: some View {
        VStack {
            if dayComplete {
                Image(systemName: "checkmark.circle.fill")
            } else {
                Image(systemName: "circle")
            }
            Text(dayInitial)
        }
    }
}
