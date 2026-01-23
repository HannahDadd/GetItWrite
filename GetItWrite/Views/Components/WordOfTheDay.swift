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
            Text("Word of the day")
                .textCase(.uppercase)
            VStack {
                Text(word?.key ?? "")
                    .foregroundColor(Color.white)
                    .font(Font.custom("Bellefair-Regular", size: 28))
                    .multilineTextAlignment(.center)
                Spacer(minLength: 24)
                Text(word?.value ?? "")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                VStack {
                    EmptyView()
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.timedGames)
            .cornerRadius(8)
        }
    }
}
