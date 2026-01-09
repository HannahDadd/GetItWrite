//
//  Timer.swift
//  Get It Write
//
//  Created by Hannah Dadd on 09/01/2026.
//

import SwiftUI

struct CountdownTimer: View {
    @State var timeRemaining: Int
    @State var quoteNumber = 0
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    let endState: () -> Void
    var timeRemainingAction: () -> Void
    
    var body: some View {
        Text("\(timeRemaining)")
            .foregroundStyle(Color.onPrimary)
            .font(.largeTitle)
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemainingAction()
                    timeRemaining -= 1
                } else {
                    endState()
                }
            }
    }
}
