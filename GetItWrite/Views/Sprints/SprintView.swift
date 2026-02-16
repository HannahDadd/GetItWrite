//
//  Sprint.swift
//  Get It Write
//
//  Created by Hannah Dadd on 08/08/2025.
//

import SwiftUI

struct SprintView: View {
    @State var quoteNumber = 0
    let endState: () -> Void
    let time: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            Text("\(GlobalVariables.inspiringQuotes[quoteNumber])")
                .foregroundColor(Color.white)
                .font(Font.custom("Bellefair-Regular", size: 28))
                .multilineTextAlignment(.center)
            Spacer()
            Text("Sprint Time Remianing:")
                .foregroundStyle(Color.white)
                .font(Font.custom("Bellefair-Regular", size: 18))
            CountdownTimer(timeRemaining: time, endState: {
                endState()
            }, textSize: 120, timeRemainingAction: { timeRemaining in
                if timeRemaining.isMultiple(of: 10) {
                    quoteNumber = Int.random(in: 1..<(GlobalVariables.inspiringQuotes.count-1))
                }
            })
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.secondary))
    }
}
