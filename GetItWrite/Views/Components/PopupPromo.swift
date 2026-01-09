//
//  PopupPromo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 28/01/2025.
//

import SwiftUI

struct PopupPromo: View {
    var title: String
    var subtitle: String
    var action: () -> Void
    
    var body: some View {
        ZStack(alignment: .leading) {
            DrawingPathsPopupPromo()
                .background(Color.primary)
            VStack(alignment: .leading) {
                Text(title)
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                    .foregroundColor(Color.onSecondary)
                Spacer()
                Text(subtitle)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .font(.subheadline)
                    .foregroundColor(Color.onSecondary)
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .cornerRadius(8)
        .onTapGesture { action() }
        .shadow(radius: 5)
        .padding()
    }
}

struct DrawingPathsPopupPromo: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 180, y: 0))
            path.addCurve(to: CGPoint(x: 150, y: 140), control1: CGPoint(x: 100, y: 75), control2: CGPoint(x: 110, y: 80))
            path.addLine(to: CGPoint(x: 0, y: 100))
        }
        .fill(Color.secondary)
        .edgesIgnoringSafeArea(.top)
    }
}

