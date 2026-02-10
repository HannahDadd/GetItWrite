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
        if let sprint = networking.sprint {
            VStack(alignment: .center, spacing: 18) {
                Text("Community sprint starting at \(sprint.timestamp)")
                    .bold()
                CountdownTimerDarkBackground(timeRemaining: 2400, endState: {
                    startSprintAction()
                }, textSize: 60, timeRemainingAction: {})
                Text("Participants").bold()
                TagCloud(tags: sprint.participants, chosenTags: .constant([]), singleTagView: false)
                Text("Join the sprint to get those words written")
                    .foregroundColor(Color.white)
                    .bold()
                    .multilineTextAlignment(.leading)
                StretchedButton(text: "Join Sprint", action: {
                    action()
                })
            }
            .padding()
        } else {
            PopupPromo(title: "Sprint with your writing community", subtitle: "Start a sprint to get those words written", action: {
                let net = UploadSession()
                net.startSprint(username: username, completion: {_ in
                    action()
                })
            })
            .padding()
        }
    }
}
