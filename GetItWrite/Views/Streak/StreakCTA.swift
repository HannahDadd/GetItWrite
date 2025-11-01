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
    
    static func incrementStreet(incrementBy: Int) {
        let encoder = JSONEncoder()
        if let data = UserDefaults.standard.data(forKey: badge.rawValue) {
            if let decoded = try? JSONDecoder().decode(Badge.self, from: data) {
                let newBadge = Badge(id: decoded.id, score: decoded.score + incrementBy, title: decoded.title)
                if let encoded = try? encoder.encode(newBadge) {
                    UserDefaults.standard.set(encoded, forKey: badge.rawValue)
                }
            }
        } else {
            let newBadge = Badge(id: UUID().hashValue, score: incrementBy, title: badge.rawValue)
            if let encoded = try? encoder.encode(newBadge) {
                UserDefaults.standard.set(encoded, forKey: badge.rawValue)
            }
        }
    }
}
