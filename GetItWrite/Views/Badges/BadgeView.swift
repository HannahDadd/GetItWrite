//
//  Badge.swift
//  Get It Write
//
//  Created by Hannah Dadd on 21/10/2025.
//

import SwiftUI

struct BadgeView: View {
    let badge: Badge
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            ZStack {
                Circle()
                    .stroke(.red, lineWidth: 5)
                    .fill(.primary)
                    .frame(width: 50, height: 50)
                Text("\(badge.score)").font(.title)
            }
            Text(badge.title).bold()
        }
    }
}
