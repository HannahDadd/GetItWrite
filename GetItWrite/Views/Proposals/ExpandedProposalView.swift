//
//  ExpandedProposalView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/05/2022.
//

import SwiftUI

struct ExpandedProposalView: View {
    @EnvironmentObject var session: FirebaseSession
    
    @State private var message = "Hello 👋 I'm interested in swapping critiques."
    @State private var writerPopup = false
    @State private var sendMessagePopup = false
    
    let proposal: Proposal
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 8) {
                    Text(proposal.title).font(.title)
                    Button(action: { writerPopup = true }) {
                        Text("By \(proposal.writerName)")
                    }
                    Divider()
                    TextAndHeader(heading: "Author's notes", text: proposal.authorNotes)
                    Divider()
                    VStack(alignment: .leading, spacing: 8) {
                        Text(proposal.typeOfProject.joined(separator: ", ")).font(.footnote)
                        TagCloud(tags: proposal.genres, onTap: nil, chosenTags: .constant([]), singleTagView: false)
                        Text("\(proposal.wordCount) words").bold()
                        Text("Blurb").bold()
                        Text(proposal.blurb)
                    }
                    if proposal.triggerWarnings.count > 0 {
                        Divider()
                        TextAndTags(heading: "TriggerWarnings:", tags: proposal.triggerWarnings)
                    }
                }
                ReportAndBlockView(content: proposal, contentType: .proposals, toBeBlockedUserId: proposal.writerId, imageScale: .large)
            }
            Spacer()
            if let hasBlockedUser = session.userData?.blockedUserIds.contains(proposal.writerId), hasBlockedUser {
                StretchedButton(text: "You blocked this user.", action: {}, isActive: false)
            } else {
                StretchedButton(text: "Send Message", action: {
                    sendMessagePopup.toggle()
                })
            }
        }.padding().sheet(isPresented: self.$writerPopup) {
            ProfileView(id: proposal.writerId)
        }.sheet(isPresented: self.$sendMessagePopup) {
            NavigationView {
                MessagesView(message: "Hello 👋 I'm interested in swapping critiques for \(proposal.title).", user2Id: proposal.writerId, user2Username: proposal.writerName).environmentObject(session)
            }
        }
    }
}
