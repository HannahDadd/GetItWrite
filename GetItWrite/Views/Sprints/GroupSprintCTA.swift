//
//  SprintCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 15/08/2025.
//

import SwiftUI

struct GroupSprintCTA: View {
    @AppStorage(UserDefaultNames.username.rawValue) private var username = ""
    @ObservedObject var networking = SprintNetworking()
    
    var action: () -> Void
    var startSprintAction: () -> Void
    
    var body: some View {
        if networking.sprints.isEmpty {
            PopupPromo(title: "Sprint with your writing community", subtitle: "Start a sprint to get those words written", action: {
                let net = UploadSession()
                net.startSprint(username: username, completion: {_ in 
                    action()
                })
            })
            .padding()
        } else {
            VStack(alignment: .leading) {
                Text("Community sprint starting at \(networking.sprints.first?.timestamp)")
                    .foregroundColor(Color.white)
                    .bold()
                Spacer()
                CountdownTimer(timeRemaining: 2400, endState: {
                    startSprintAction()
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
            .background(Color.GetItWriteCTA)
            .cornerRadius(8)
            .onTapGesture {
                action()
            }
            .padding()
        }
    }
}
