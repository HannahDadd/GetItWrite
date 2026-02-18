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
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let endState: () -> Void
    let textSize: CGFloat
    var timeRemainingAction: (Int) -> Void
    
    var body: some View {
        Text(String(format: "%d:%02d", timeRemaining / 60, timeRemaining % 60))
            .foregroundStyle(Color.white)
            .font(Font.custom("AbrilFatface-Regular", size: textSize))
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemainingAction(timeRemaining)
                    timeRemaining -= 1
                } else {
                    endState()
                }
            }
    }
}

struct CountdownTimerDarkBackground: View {
    @State var timeRemaining: Int
    @State var quoteNumber = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let endState: () -> Void
    let textSize: CGFloat
    var timeRemainingAction: () -> Void
    
    var body: some View {
        Text(String(format: "%d:%02d", timeRemaining / 60, timeRemaining % 60))
            .font(Font.custom("AbrilFatface-Regular", size: textSize))
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
