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
        VStack {
            ScrollView {
                HStack {
                    VStack(alignment: .leading) {
                        Text(text)
                            .font(.headline)
                            .foregroundColor(Color.onCardBackground)
                            .bold()
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .background(Color.cardBackground)
                    .cornerRadius(8)
                    .onTapGesture {
                    }
                }
            }
        }
    }
}
