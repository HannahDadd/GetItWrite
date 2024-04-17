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
    @State private var showingError = false
	@State var chosenWord: String = ""
	@State private var comment = ""
	@State private var instance = 0

	@State private var overallComments = ""
	@State private var comments = [Int : String]()
	@State private var errorMessagePopup: String = ""
    @State private var errorMessage: String = ""

	let requestCritique: RequestCritique
	let paragraphs: [String]

	init(requestCritique: RequestCritique) {
		paragraphs = requestCritique.text.components(separatedBy: "\n")
		self.requestCritique = requestCritique
	}

	var body: some View {
		ScrollView {
			VStack(spacing: 8) {
				Text(requestCritique.workTitle).font(.title)
				Text(requestCritique.title).font(.title3)
				Text("By \(requestCritique.writerName)")
				TagCloud(tags: requestCritique.genres, onTap: nil, chosenTags: .constant([]), singleTagView: false)
				if requestCritique.triggerWarnings.count > 0 {
					Divider()
					Text("Trigger Warnings:").font(.footnote)
					TagCloud(tags: requestCritique.triggerWarnings, chosenTags: .constant([]), singleTagView: false)
				}
				Divider()
				ExpandableText(heading: "Blurb:", text: requestCritique.blurb, headingPreExpand: "Expand Blurb")
                ReportAndBlockView(content: requestCritique, contentType: .requestCritiques, toBeBlockedUserId: requestCritique.writerId, imageScale: .large)
				Divider()
			}
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
                    session.submitCritique(requestCritique: requestCritique, comments: comments, overallFeedback: overallComments) {error in
                        if let error {
                            errorMessage = error.localizedDescription
                        } else {
                            backToFeed = true
                        }
                    }
				})
                ErrorText(errorMessage: errorMessage)
			}
			NavigationLink(destination: LandingPage().environmentObject(session), isActive: self.$backToFeed) {
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
				ErrorText(errorMessage: errorMessagePopup)
				QuestionSection(text: "Comment:", response: $comment)
				StretchedButton(text: "Comment!", action: {
					if comment == "" {
						errorMessagePopup = "Write comment below."
					} else {
						wordTapped = false
						comments[instance] = comment
						comment = ""
						errorMessagePopup = ""
					}
				})
			}.padding()
		}.alert("Something went wrong!", isPresented: $showingError) {
            Button("OK", role: .cancel) { }
        }
	}
}
