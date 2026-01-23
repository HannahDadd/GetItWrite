//
//  WordOfTheDay.swift
//  Get It Write
//
//  Created by Hannah Dadd on 23/01/2026.
//

import SwiftUI

struct WordoftheDayCard: View {
    let word = GlobalVariables.vocabMap.shuffled().first
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Learn a new word")
                .textCase(.uppercase)
            VStack {
                Text(word?.key ?? "")
                    .foregroundColor(Color.white)
                    .font(Font.custom("Bellefair-Regular", size: 18))
                    .multilineTextAlignment(.center)
                Spacer()
                Text(word?.value ?? "")
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                VStack {
                    EmptyView()
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(height: 150)
            .frame(maxWidth: .infinity)
            .background(Color.timedGames)
            .cornerRadius(8)
        }
    }
}
