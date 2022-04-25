//
//  GiveCritiqueView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 22/04/2022.
//

import SwiftUI

struct GiveCritiqueView: View {
	@EnvironmentObject var session: FirebaseSession

	@State private var wordTapped = false
	@State private var comment = ""
	@State private var overallComments = ""
	@State private var word = ""
	@State private var instance = 0
	@State private var comments: [Comment] = []

	let work: Work

	var body: some View {
		VStack {
			ScrollView {
				Text(work.title).font(.title)
				Divider()
				ExpandableText(heading: "Blurb:", text: work.blurb)
				if work.synopsisSoFar != "" {
					ExpandableText(heading: "Synopsis so Far:", text: work.synopsisSoFar).padding(.top, 10)
				}
				Divider()
				CommentableText(words: work.text.components(separatedBy: " "), wordTapped: $wordTapped, instance: $instance)
				Divider()
				Text("Comments: \(comments.count)").font(.caption)
					.frame(maxWidth: .infinity, alignment: .trailing)
				Spacer()
				Group {
					QuestionSection(text: "Overall Feedback:", response: $overallComments)
					StretchedButton(text: "Submit Critique", action: {
					})

				}
			}
			if wordTapped {
				QuestionSection(text: "Comment:", response: $comment)
				StretchedButton(text: "Comment!", action: {
					wordTapped = false
					comments.append(Comment(id: UUID().uuidString, comment: comment, instance: instance))
					comment = ""
				})
			}
		}.padding()
	}
}
