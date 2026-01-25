//
//  StreakDay.swift
//  Get It Write
//
//  Created by Hannah Dadd on 25/01/2026.
//

import SwiftUI

struct StreakDay: View {
    let dayInitial: String
    let dayComplete: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            if dayComplete {
                Image(systemName: "checkmark.circle.fill")
            } else {
                Image(systemName: "circle")
            }
            Text(dayInitial)
                .font(Font.custom("Bellefair-Regular", size: 22))
        }
        .frame(maxWidth: .infinity)
    }
}
