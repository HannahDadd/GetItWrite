//
//  MakePositivityCard.swift
//  Get It Write
//
//  Created by Hannah Dadd on 31/01/2025.
//

import SwiftUI

struct MakePositivityCard: View {
    @EnvironmentObject var session: FirebaseSession
    @State var showPopUp = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            DrawingPathsTwo()
                .background(Color.makePosCard)
            VStack(alignment: .leading) {
                Text("Need some Positive Energy?")
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Spacer()
                Text("Post your work here to get positive vibes from the community.")
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
            .padding()
        }
        .frame(width: 300, height: 140)
        .cornerRadius(8)
        .sheet(isPresented: self.$showPopUp) {
            MakePositivity(showMakeCritiqueView: self.$showPopUp)
        }
    }
}

struct DrawingPathsTwo: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addCurve(to: CGPoint(x: 300, y: 140), control1: CGPoint(x: 100, y: 75), control2: CGPoint(x: 110, y: 80))
            path.addLine(to: CGPoint(x: 0, y: 140))
        }
        .fill(Color.makePosSquiggle)
        .edgesIgnoringSafeArea(.top)
    }
}
