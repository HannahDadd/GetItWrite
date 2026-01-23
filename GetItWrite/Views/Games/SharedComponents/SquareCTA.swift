//
//  SquareCTA.swift
//  Writing Games
//
//  Created by Hannah Dadd on 16/01/2026.
//

import SwiftUI

struct SquareCTA: View {
    let gameType: GameTypes
    let colour: Color
    var action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: gameType.getIcon())
                .font(.system(size: 45))
                .foregroundColor(Color.white)
            Spacer()
            Text(gameType.getTitle())
                .font(Font.custom("Bellefair-Regular", size: 18))
                .foregroundColor(Color.white)
            VStack {
                EmptyView()
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(height: 110)
        .frame(maxWidth: .infinity)
        .background(colour)
        .cornerRadius(8)
        .onTapGesture {
            action()
        }
    }
}
