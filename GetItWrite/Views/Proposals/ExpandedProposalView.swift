//
//  ExpandedProposalView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/05/2022.
//

import SwiftUI

struct ExpandedProposalView: View {
	@EnvironmentObject var session: FirebaseSession
	@State private var message = ""
	@State private var messageSent = false

	let proposal: Proposal

	var body: some View {
		ScrollView {
			VStack(spacing: 8) {
				Text(proposal.title).font(.title)
				Text("By \(proposal.writerName)")
				TagCloud(tags: proposal.genres, onTap: nil, chosenTags: .constant([]), singleTagView: false)
				if proposal.triggerWarnings.count > 0 {
					Divider()
					Text("Trigger Warnings:").font(.footnote)
					TagCloud(tags: proposal.triggerWarnings, chosenTags: .constant([]), singleTagView: false)
				}
				Divider()
				Text(proposal.blurb)
				Divider()
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
			}
		}
	}
}
