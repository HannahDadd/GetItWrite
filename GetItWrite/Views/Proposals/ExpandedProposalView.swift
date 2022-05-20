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
	@State private var messageSent = false
	@State private var writerPopup = false

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
					TagCloud(tags: proposal.genres, onTap: nil, chosenTags: .constant([]), singleTagView: false)
					Text("\(proposal.wordCount) words")
					if proposal.triggerWarnings.count > 0 {
						Divider()
						Text("Trigger Warnings:").font(.footnote)
						TagCloud(tags: proposal.triggerWarnings, chosenTags: .constant([]), singleTagView: false)
					}
					Divider()
					Text(proposal.blurb)
				}
			}
			Spacer()
			if messageSent {
				HStack {
					Text("Message sent ").bold()
					Image(systemName: "checkmark.circle")
				}
			} else {
				QuestionSection(text: "Message Writer", response: $message)
				StretchedButton(text: "Send Message", action: {
					messageSent.toggle()
					//					   session.submitCritique(project: project, comments: comments, overallFeedback: overallComments)
				})
			}
		}.padding().sheet(isPresented: self.$writerPopup) {
			ProfileView(id: proposal.writerId)
		}
	}
}
