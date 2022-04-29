//
//  ViewCritiqueView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 29/04/2022.
//

import SwiftUI

struct ViewCritiqueView: View {
	@EnvironmentObject var session: FirebaseSession
	
	@State private var wordTapped = false
	@State var chosenWord: String = ""
	@State private var comment = ""
	@State private var instance = 0
	
	let critique: Critique
	let project: Project
	let paragraphs: [String]
	let comments: [Int: String]
	
	init(project: Project, critique: Critique) {
		paragraphs = project.text.components(separatedBy: "\n")
		comments = Dictionary(uniqueKeysWithValues: critique.comments.map({ ($1, $0) }))
		self.project = project
		self.critique = critique
	}
	
	var body: some View {
		VStack {
			ScrollView {
				ProjectMetadataView(project: project)
				ForEach(0..<paragraphs.count, id: \.self) { i in
					Text(paragraphs[i]).frame(maxWidth: .infinity, alignment: .leading)
						.background(chosenWord == paragraphs[i] && wordTapped ? .yellow : comments[i] != nil ? Color.bold : .clear)
						.onTapGesture {
							if comments[i] != nil {
								wordTapped.toggle()
								if wordTapped {
									chosenWord = paragraphs[i]
									comment = comments[i] ?? ""
									instance = i
								}
							}
						}.padding(.bottom, 8)
				}
				Spacer()
				VStack {
					Divider()
					Text("Comments: \(comments.count)").font(.caption)
						.frame(maxWidth: .infinity, alignment: .trailing)
					StretchedButton(text: "Rate Critique", action: {
					})
				}
			}
		}.padding().popover(isPresented: $wordTapped,
							attachmentAnchor: .point(.bottom),
							arrowEdge: .trailing) {
			VStack {
				ScrollView {
					TextAndHeader(heading: "Paragraph:", text: paragraphs[instance])
					Spacer()
				}
				TextAndHeader(heading: "Critiquers comment:", text: comment)
			}.padding()
		}
	}
}
