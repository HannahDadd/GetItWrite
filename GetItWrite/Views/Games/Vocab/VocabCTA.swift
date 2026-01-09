//
//  VocabCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 20/10/2025.
//

import SwiftUI

struct VocabCTA: View {
    
    var body: some View {
        ZStack(alignment: .leading) {
            DrawingPaths()
                .background(Color.critiquePositivityCard)
            VStack(alignment: .leading) {
                Text("Improve your vocabulary!")
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
        .frame(width: 300, height: 140)
        .cornerRadius(8)
    }
}

struct DrawingPaths: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 180, y: 0))
            path.addCurve(to: CGPoint(x: 300, y: 140), control1: CGPoint(x: 100, y: 75), control2: CGPoint(x: 110, y: 80))
            path.addLine(to: CGPoint(x: 300, y: 0))
        }
        .fill(Color.critiquePosSquiggle)
        .edgesIgnoringSafeArea(.top)
    }
}
