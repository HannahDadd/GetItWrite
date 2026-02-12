//
//  SprintCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 15/08/2025.
//

import SwiftUI

struct GroupSprintCTA: View {
    @AppStorage(UserDefaultNames.username.rawValue) private var username = ""
    @EnvironmentObject var networking: SprintNetworking
    
    let uploader = UploadSession()
    var action: () -> Void
    
    var body: some View {
        if let sprint = networking.sprint, sprint.timestamp.dateValue() > Date.now {
            VStack(alignment: .center, spacing: 18) {
                Text("Community sprint starting at \(sprint.formatDate())")
                    .font(Font.custom("Bellefair-Regular", size: 22))
                CountdownTimerDarkBackground(timeRemaining: Int(sprint.timestamp.dateValue().timeIntervalSince1970 - Date.now.timeIntervalSince1970), endState: {}, textSize: 60, timeRemainingAction: {})
                Text("Participants").bold()
                TagCloud(tags: sprint.participants.keys.compactMap { $0 }, chosenTags: .constant([]), singleTagView: false)
                StretchedButton(text: "Join Sprint", action: {
                    uploader.joinSprint(sprint: sprint, username: username, completion: {_ in 
                        action()
                    })
                })
            }
            .padding()
        } else {
            VStack(alignment: .center, spacing: 18) {
                Text("No Community Sprint Running")
                    .font(Font.custom("Bellefair-Regular", size: 28))
                    .foregroundColor(.white)
                HStack {
                    VStack {
                        Spacer()
                        Text("Tap here to start a sprint")
                            .font(Font.custom("Bellefair-Regular", size: 22))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Image(systemName: "books.vertical.fill")
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal) { size, axis in
                            size * 0.4
                        }
                        .foregroundStyle(.white)
                }
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
            .padding()
        }
    }
}
