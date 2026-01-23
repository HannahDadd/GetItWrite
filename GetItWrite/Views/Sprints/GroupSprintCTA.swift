//
//  SprintCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 15/08/2025.
//

import SwiftUI

struct GroupSprintCTA: View {
    var action: () -> Void
    
    var body: some View {
        if true {
            PopupPromo(title: "Sprint with your writing community", subtitle: "Start a sprint to get those words written", action: {
                action()
            })
            .padding()
        } else {
            VStack(alignment: .leading) {
                Text("Community sprint starting in")
                    .foregroundColor(Color.white)
                    .bold()
                Spacer()
                CountdownTimer(timeRemaining: 2400, endState: {
                    
                }, textSize: 60, timeRemainingAction: {})
                Spacer()
                Text("Join the sprint to get those words written")
                    .foregroundColor(Color.white)
                    .bold()
                    .multilineTextAlignment(.leading)
                VStack {
                    EmptyView()
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: 150)
            .frame(maxWidth: .infinity)
            .background(Color.brightGreen)
            .cornerRadius(8)
            .onTapGesture {
                action()
            }
            .padding()
        }
    }
}
