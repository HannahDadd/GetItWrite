//
//  Badge.swift
//  Get It Write
//
//  Created by Hannah Dadd on 21/10/2025.
//

import SwiftUI

struct BadgeView: View {
    @State var showPopUp = false
    @State var badge: Badge
    let onTapText: String
    let shouldShowPopup: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            ZStack {
                Circle()
                    .fill(shouldShowPopup ? Color.tappableBadgeBG : Color.badgeBg)
                    .frame(width: 50, height: 50)
                Text("\(badge.score)")
                    .foregroundStyle(Color.white)
                    .font(Font.custom("AbrilFatface-Regular", size: 24))
            }
            Text(badge.title).bold()
        }
        .onTapGesture(count: 2) {
            if !showPopUp {
                resetValue()
            }
        }
        .onTapGesture(count: 1) {
            if shouldShowPopup {
                showPopUp = true
            } else {
                incrementValue()
            }
        }
        .alert(onTapText, isPresented: $showPopUp) {
            Button("Close", role: .cancel) { }
        }
    }
    
    func resetValue() {
        let encoder = JSONEncoder()
        badge.score = 0
        if let encoded = try? encoder.encode(badge) {
            UserDefaults.standard.set(encoded, forKey: badge.title)
        }
    }
    
    func incrementValue() {
        let encoder = JSONEncoder()
        badge.score = badge.score + 1
        if let encoded = try? encoder.encode(badge) {
            UserDefaults.standard.set(encoded, forKey: badge.title)
        }
    }
}
