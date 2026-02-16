//
//  SprintBadge.swift
//  Get It Write
//
//  Created by Hannah Dadd on 16/02/2026.
//

import SwiftUI

struct SprintBadge: View {
    @AppStorage var achevied: Bool
    let badge: Badge
    let width: CGFloat
    
    init(badge: Badge, width: CGFloat) {
        self.width = width
        self.badge = badge
        _achevied = AppStorage(wrappedValue: false, badge.rawValue)
    }
    
    var body: some View {
        VStack {
            Image(badge.getImage())
                .foregroundColor(.white)
                .padding(10)
                .background(achevied ? Color.toneCard : Color.gray)
                .clipShape(Circle())
            Spacer()
            Text(badge.getText())
        }
        .padding()
        .frame(width: width, height: 150)
        .background(.white)
        .cornerRadius(8)
    }
}
