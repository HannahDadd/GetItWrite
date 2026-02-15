//
//  BadgePromo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 12/02/2026.
//

import SwiftUI

struct BadgePromo: View {
    @AppStorage var achevied: Bool
    let badge: Badge
    
    init(badge: Badge, userDefaultName: String) {
        self.badge = badge
        _achevied = AppStorage(wrappedValue: false, userDefaultName)
    }
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: achevied ? badge.getImage() : "")
                .foregroundColor(.white)
                .padding(10)
                .background(achevied ? Color.toneCard : Color.gray)
                .clipShape(Circle())
            Text(badge.getText())
                .multilineTextAlignment(.leading)
                .font(Font.custom("Bellefair-Regular", size: 18))
            Spacer()
            if achevied {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(Color.toneCard)
            } else {
                Image(systemName: "lock.fill")
                    .foregroundStyle(.gray)
            }
        }
        .padding(.vertical)
    }
}
