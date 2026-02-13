//
//  BadgePromo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 12/02/2026.
//

import SwiftUI

struct BadgePromo: View {
    var title: String
    var imageName: String
    var achevied: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: achevied ? imageName : "")
                .foregroundColor(.white)
                .padding(10)
                .background(achevied ? Color.toneCard : Color.gray)
                .clipShape(Circle())
            Text(title)
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
