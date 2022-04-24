//
//  GiveCritiqueView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 22/04/2022.
//

import SwiftUI

struct GiveCritiqueView: View {
//	@EnvironmentObject var session: FirebaseSession
	@State private var expanded = false
	@State private var wordTapped = false
	@State private var comment = ""
	@State private var word = ""
	@State private var instance = 0

	private var comments: [Comment] = []
	let work: Work

	var body: some View {
		VStack {
			ScrollView {
				Text(work.title).font(.title)
				Divider()
				Text(work.blurb).lineLimit(expanded ? nil : 3)
				Text(expanded ? "Show less" : "Show more").bold().onTapGesture {
					expanded.toggle()
				}
				Divider()
//				Text(work.text)
//				ForEach(work.text.components(separatedBy: "."), id: \.self) { text in
//					Text(text).onTapGesture {
//						print(text)
//					}
//				}
				CommentableText(words: work.text.components(separatedBy: " "), wordTapped: $wordTapped)
			}
			if wordTapped {
				QuestionSection(text: "Comment:", response: $comment)
				StretchedButton(text: "Comment!", action: {
					wordTapped = false
					comments.append([Comment(id: UUID().uuidString, comment: comment, word: <#T##String#>, instance: <#T##Int#>)])
				})
			}
		}.padding()
	}
}
