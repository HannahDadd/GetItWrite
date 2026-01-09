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
        VStack {
            ZStack {
                Text("\(badge.score)").font(.title)
                Circle()
                    .stroke(.red, lineWidth: 20)
                    .fill(.orange)
                    .frame(width: 150, height: 150)
            }
            Text(badge.title).bold()
        }
    }
}
