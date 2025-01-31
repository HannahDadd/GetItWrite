//
//  CarouselCard.swift
//  Get It Write
//
//  Created by Hannah Dadd on 28/01/2025.
//

import SwiftUI

enum CardType {
    case positivity
    case normal
    case noticeboard
}

struct CarouselCard: View {
    let icon: String
    let title: String
    let bubbleText: String?
    var cardType: CardType = .normal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 15)
            Text(title)
                .font(.headline)
                .foregroundColor(Color.onCardBackground)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            if cardType != .positivity {
                Spacer()
            }
            HStack {
                Spacer()
                if let bubbleText = bubbleText {
                    Text(bubbleText)
                        .padding(6)
                        .font(.caption)
                        .background(Color.secondary)
                        .foregroundColor(Color.onSecondary)
                        .clipShape(.capsule)
                }
            }
        }
        .padding()
        .frame(width: getWidthAndHeight(), height: getWidthAndHeight())
        .background(Color.cardBackground)
        .cornerRadius(8)
    }
    
    func getWidthAndHeight() -> CGFloat {
        switch cardType {
        case .normal:
            return CGFloat(175)
        case .positivity:
            return CGFloat(75)
        case .noticeboard:
            return CGFloat(140)
        }
    }
}
