//
//  StartSprintCard.swift
//  Get It Write
//
//  Created by Hannah Dadd on 09/01/2026.
//

import SwiftUI

struct StartSprintCard: View {
    var action: () -> Void
    let text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(text)
                .font(Font.custom("AbrilFatface-Regular", size: 28))
                .foregroundColor(Color.white)
                .bold()
                .multilineTextAlignment(.leading)
        }
        .padding()
        .frame(width: 150, height: 100)
        .background(Color.brightBlue)
        .cornerRadius(8)
        .onTapGesture {
            action()
        }
    }
}
