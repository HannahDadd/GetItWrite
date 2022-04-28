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
	@State var chosenWord: String = ""
	@State private var comment = ""
	@State private var word = ""
	@State private var instance = 0

	@State private var overallComments = ""
	@State private var comments = [Int : String]()
	@State private var errorMessage: String = ""

	let work: Work
	let paragraphs: [String]

	init(work: Work) {
		paragraphs = work.text.components(separatedBy: "\n")
		self.work = work
	}

	var body: some View {
		VStack {
			ScrollView {
				Text(work.title).font(.title)
				Text("By \(work.posterUsername)")
				TagCloud(tags: work.genres, onTap: nil, chosenTag: .constant(""), singleTagView: false)
				Divider()
				ExpandableText(heading: "Blurb:", text: work.blurb, headingPreExpand: "Expand Blurb")
				if work.synopsisSoFar != "" {
					ExpandableText(heading: "Synopsis so Far:", text: work.synopsisSoFar, headingPreExpand: "Expand Synopsis").padding(.top, 10)
				}
				Divider()
				ForEach(0..<paragraphs.count, id: \.self) { i in
					Text(paragraphs[i]).frame(maxWidth: .infinity, alignment: .leading)
						.background(chosenWord == paragraphs[i] && wordTapped ? .yellow : comments[i] != nil ? Color.bold : .clear)
						.onTapGesture {
							wordTapped.toggle()
							if wordTapped {
								chosenWord = paragraphs[i]
								comment = comments[i] ?? ""
								instance = i
							}
						}
				}
				Spacer()
				VStack {
					Divider()
					Text("Comments: \(comments.count)").font(.caption)
						.frame(maxWidth: .infinity, alignment: .trailing)
					QuestionSection(text: "Overall Feedback:", response: $overallComments)
					StretchedButton(text: "Submit Critique", action: {
						session.submitCritique(workId: work.id, comments: comments, overallFeedback: overallComments)
					})
				}
			}
		}.padding().popover(isPresented: $wordTapped,
							attachmentAnchor: .point(.bottom),
							arrowEdge: .trailing) {
			VStack {
				ScrollView {
					Text("Paragraph:").bold().frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 8)
					Text(paragraphs[instance]).frame(maxWidth: .infinity, alignment: .leading)
					Spacer()
				}
				ErrorText(errorMessage: errorMessage)
				QuestionSection(text: "Comment:", response: $comment)
				StretchedButton(text: "Comment!", action: {
					if comment == "" {
						errorMessage = "Write comment below."
					} else {
						wordTapped = false
						comments[instance] = comment
						comment = ""
						errorMessage = ""
					}
				})
			}.padding()
		}
	}
}
