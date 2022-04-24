//
//  GiveCritiqueView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 22/04/2022.
//

import SwiftUI

struct GiveCritiqueView: View {
//	@EnvironmentObject var session: FirebaseSession
	@State private var wordTapped = false
	@State private var comment = ""
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
				if let synopsisSoFar = work.synopsisSoFar {
					ExpandableText(heading: "Synopsis so Far:", text: synopsisSoFar)
				}
				Divider()
				CommentableText(words: work.text.components(separatedBy: " "), wordTapped: $wordTapped, instance: $instance)
				Spacer()
				Divider()
				Text("Comments: \(comments.count)").font(.caption)
				StretchedButton(text: "Submit Critique", action: {
				})
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
