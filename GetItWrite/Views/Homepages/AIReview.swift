//
//  AIReview.swift
//  Get It Write
//
//  Created by Hannah Dadd on 02/09/2024.
//

import SwiftUI

import SwiftUI

struct AIPromo: View {
    @State var showPopUp = false

    var body: some View {
        ZStack(alignment: .leading) {
            DrawingPathsAIPromo()
                .background(Color.aiBg)
            VStack(alignment: .leading) {
                Text("Need quick Feedback?")
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Spacer()
                Text("Try our AI.")
                    .font(.subheadline)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
            .padding()
        }
        .frame(width: 300, height: 140)
        .cornerRadius(8)
        .sheet(isPresented: self.$showPopUp) {
            AIReview()
        }
    }
}

struct AIReview: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DrawingPathsAIPromo: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addCurve(to: CGPoint(x: 300, y: 140), control1: CGPoint(x: 100, y: 75), control2: CGPoint(x: 110, y: 80))
            path.addLine(to: CGPoint(x: 0, y: 140))
        }
        .fill(Color.aiForeground)
        .edgesIgnoringSafeArea(.top)
    }
}
