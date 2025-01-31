//
//  BulletinCard.swift
//  Get It Write
//
//  Created by Hannah Dadd on 28/01/2025.
//

import SwiftUI

struct BulletinCard: View {
    let bulletin: Bulletin
    let isFeed: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(bulletin.writerName)
                .font(.caption)
                .foregroundColor(Color.subtitleGenre)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
            Spacer()
            Text(bulletin.text)
                .font(.headline)
                .foregroundColor(Color.onCardBackground)
                .bold()
                .multilineTextAlignment(.leading)
                .lineLimit(5)
        }
        .padding()
        .frame(height: 140)
        .frame(maxWidth: isFeed ? .infinity : 320)
        .background(Color.cardBackground)
        .cornerRadius(8)
    }
}
