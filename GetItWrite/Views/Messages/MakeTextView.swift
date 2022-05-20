//
//  MakeTextView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 25/04/2022.
//

import SwiftUI

struct MakeTextView: View {
	@EnvironmentObject var session: FirebaseSession

	@State private var text: String = ""
	@State private var errorMessage: String = ""
	@State var project: Project?
	@State private var title: String = ""

	let userId: String

	@Binding var showingComposeMessage: Bool

	var body: some View {
		VStack {
			SelectProjectView(project: $project).environmentObject(session)
			TextField("Title of Critique", text: $title).textFieldStyle(RoundedBorderTextFieldStyle())
			Text("Add text here:").bold().frame(maxWidth: .infinity, alignment: .leading)
			TextEditor(text: $text)
			ErrorText(errorMessage: errorMessage)
			StretchedButton(text: "Request Critique", action: {
				if text == "" {
					errorMessage = "Paste or type your project above."
				} else {
					if let chosenProject = project {
						session.newCritiqueRequest(title: title, text: text, userId: userId, project: chosenProject)
					} else {
						errorMessage = "Please select a project to receive a critique for."
					}
					showingComposeMessage.toggle()
				}
			})
		}.padding()
	}
}
