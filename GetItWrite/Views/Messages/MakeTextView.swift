//
//  MakeTextView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 25/04/2022.
//

import SwiftUI

struct MakeTextView: View {
	@EnvironmentObject var session: FirebaseSession

	let chatId: String
	let userId: String
	let displayName2: String

	@State private var text: String = ""
	@State private var errorMessage: String = ""
	@State var project: Proposal?
	@State private var title: String = ""

	@Binding var showMakeCritiqueView: Bool

	var body: some View {
		VStack {
            SelectProposalSection(project: $project).environmentObject(session)
			TextField("Title of Critique", text: $title).textFieldStyle(RoundedBorderTextFieldStyle())
			Text("Add text here:").bold().frame(maxWidth: .infinity, alignment: .leading)
			TextEditor(text: $text)
			ErrorText(errorMessage: errorMessage)
			StretchedButton(text: "Request Critique", action: {
				if text == "" {
					errorMessage = "Paste or type your project above."
				} else if title == "" {
					errorMessage = "Please include a title."
				} else if text.components(separatedBy: .whitespacesAndNewlines).count > 10000 {
					errorMessage = "Word limit of 10000. Please select a smaller peice of text e.g. a single chapter, query or synopsis. This ensures reviews are quick."
				} else {
					if let chosenProject = project {
                        session.newCritiqueRequest(title: title, text: text, userId: userId, project: chosenProject) { err in
                            if let err {
                                errorMessage = "Whoops something went wrong! Try again later. Error message: \(err.localizedDescription)"
                            } else {
                                session.sendMessage(content: "WORK SENT!\n\(session.userData?.displayName ?? "") sent their work entitled '\(title)' to \(displayName2)", chatId: chatId)
                                showMakeCritiqueView.toggle()
                            }
                        }
					} else {
						errorMessage = "Please select a project to receive a critique for."
					}
				}
			})
		}.padding()
	}
}
