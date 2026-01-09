//
//  WordOfTheDay.swift
//  Get It Write
//
//  Created by Hannah Dadd on 24/10/2025.
//

import SwiftUI

struct WordoftheDayCard: View {
    let word = GlobalVariables.vocabMap.shuffled().first
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Learn a new word").textCase(.uppercase)
            VStack(alignment: .leading) {
                Text(word?.key ?? "")
                    .font(.headline)
                    .foregroundColor(Color.onCardBackground)
                    .bold()
                    .multilineTextAlignment(.leading)
                Spacer()
                Text(word?.value ?? "")
                    .font(.headline)
                    .foregroundColor(Color.onCardBackground)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                VStack {
                    EmptyView()
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(height: 150)
            .frame(maxWidth: .infinity)
            .background(Color.cardBackground)
            .cornerRadius(8)
        }
    }
}
