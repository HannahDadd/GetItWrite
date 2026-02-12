//
//  Sprint.swift
//  Get It Write
//
//  Created by Hannah Dadd on 08/08/2025.
//

import SwiftUI

struct SprintView: View {
    @State var timeRemaining: Int
    @State var quoteNumber = 0
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    let endState: () -> Void

    var body: some View {
        ZStack {
            Color.primary
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("\(GlobalVariables.inspiringQuotes[quoteNumber])")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.onPrimary)
                    .font(.largeTitle)
                Spacer()
                Text("Sprint Time Remianing (minutes):")
                    .foregroundStyle(Color.onPrimary)
                    .font(.headline)
                Text("\(timeRemaining)")
                    .foregroundStyle(Color.onPrimary)
                    .font(.largeTitle)
                    .onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            if timeRemaining.isMultiple(of: 10) {
                                quoteNumber = Int.random(in: 1..<(GlobalVariables.inspiringQuotes.count-1))
                            }
                            timeRemaining -= 1
                        } else {
                            endState()
                        }
                    }
                Spacer()
            }
            .padding()
        }
    }
}
