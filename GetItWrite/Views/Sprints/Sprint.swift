//
//  Sprint.swift
//  Get It Write
//
//  Created by Hannah Dadd on 08/08/2025.
//

import SwiftUI

struct Sprint: View {
    @State var timeRemaining = 120
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let endState: () -> Void

    var body: some View {
        VStack {
            Spacer()
            Text("\(GlobalVariables.inspiringQuotes[4])")
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            Spacer()
            Text("\(timeRemaining)")
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .onReceive(timer) { _ in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    } else {
                        endState()
                    }
                }
            Spacer()
        }.background(Color.purple)
    }
}
