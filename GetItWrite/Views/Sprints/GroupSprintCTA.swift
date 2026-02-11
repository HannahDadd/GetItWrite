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
    
    let uploader = UploadSession()
    
    var action: () -> Void
    var startSprintAction: () -> Void
    
    var body: some View {
        if let sprint = networking.sprint, sprint.timestamp.dateValue() > Date.now {
            VStack(alignment: .center, spacing: 18) {
                Text("Community sprint starting at \(sprint.formatDate())")
                    .font(Font.custom("Bellefair-Regular", size: 22))
                CountdownTimerDarkBackground(timeRemaining: Int(sprint.timestamp.dateValue().timeIntervalSince1970 - Date.now.timeIntervalSince1970), endState: {
                    startSprintAction()
                }, textSize: 60, timeRemainingAction: {})
                Text("Participants").bold()
                TagCloud(tags: sprint.participants, chosenTags: .constant([]), singleTagView: false)
                StretchedButton(text: "Join Sprint", action: {
                    uploader.joinSprint(sprint: sprint, username: username, completion: {_ in 
                        
                    })
                })
            }
            .padding()
        } else {
            VStack(alignment: .center, spacing: 18) {
                Text("No community sprint running")
                    .font(.headline)
                    .foregroundColor(.white)
                Image(systemName: "bell.fill")
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { size, axis in
                        size * 0.6
                    }
                    .foregroundStyle(.white)
                Text("Start a sprint to get those words written")
                    .lineLimit(2)
                    .font(.subheadline)
                    .foregroundColor(.white)
                VStack {
                    EmptyView()
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.GetItWriteCTA)
            .cornerRadius(8)
            .onTapGesture {
                uploader.startSprint(username: username, completion: {_ in
                    action()
                })
            }
            .shadow(radius: 5)
        }
    }
}
