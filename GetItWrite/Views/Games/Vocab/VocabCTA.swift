//
//  VocabCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 20/10/2025.
//

import SwiftUI

struct VocabCTA: View {
    var action: () -> Void
    
    var body: some View {
        ZStack(alignment: .leading) {
            DrawingPaths()
                .background(Color.vocabCTA)
            VStack(alignment: .leading) {
                Text("Test your vocabulary!")
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Spacer()
                Text("Play a game of matchy matchy.")
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

struct DrawingPaths: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 180, y: 0))
            path.addCurve(to: CGPoint(x: 300, y: 140), control1: CGPoint(x: 100, y: 75), control2: CGPoint(x: 110, y: 80))
            path.addLine(to: CGPoint(x: 5000, y: 500))
            path.addLine(to: CGPoint(x: 5000, y: 0))
        }
        .fill(Color.vocabCTASquiggle)
        .edgesIgnoringSafeArea(.top)
    }
}
