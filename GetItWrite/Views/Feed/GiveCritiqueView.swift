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
	@State private var backToFeed = false
	@State var chosenWord: String = ""
	@State private var comment = ""
	@State private var instance = 0

	@State private var overallComments = ""
	@State private var comments = [Int : String]()
	@State private var errorMessage: String = ""

	let project: Project
	let paragraphs: [String]

	init(project: Project) {
		paragraphs = project.text.components(separatedBy: "\n")
		self.project = project
	}

	var body: some View {
			ScrollView {
				ProjectMetadataView(project: project)
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
						}.padding(.bottom, 8)
				}
				Spacer()
				VStack {
					Divider()
					Text("Comments: \(comments.count)").font(.caption)
						.frame(maxWidth: .infinity, alignment: .trailing)
					QuestionSection(text: "Overall Feedback:", response: $overallComments)
					StretchedButton(text: "Submit Critique", action: {
						session.submitCritique(project: project, comments: comments, overallFeedback: overallComments)
						backToFeed = true
					})
				}
				NavigationLink(destination: FeedView().environmentObject(session), isActive: self.$backToFeed) {
		 EmptyView()
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
