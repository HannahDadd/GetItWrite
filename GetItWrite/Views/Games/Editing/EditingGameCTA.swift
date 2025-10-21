//
//  ReplaceWordCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 21/10/2025.
//

import SwiftUI

struct EditingGameCTA: View {
    var action: () -> Void
    
    var body: some View {
        ZStack(alignment: .leading) {
            DrawingPathsToneCTA()
                .background(Color.toneCard)
            VStack(alignment: .leading) {
                Text("Practice editing")
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Spacer()
                Text("Practice your editing skills on these sentences.")
                    .font(.subheadline)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
            .padding()
        }
        .frame(height: 140)
        .frame(maxWidth: .infinity)
        .cornerRadius(8)
        .onTapGesture {
            action()
        }
    }
}

struct DrawingPathsToneCTA: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 180, y: 0))
            path.addCurve(to: CGPoint(x: 150, y: 140), control1: CGPoint(x: 100, y: 75), control2: CGPoint(x: 110, y: 80))
            path.addLine(to: CGPoint(x: 0, y: 100))
        }
        .fill(Color.toneSquiggle)
        .edgesIgnoringSafeArea(.top)
    }
}
