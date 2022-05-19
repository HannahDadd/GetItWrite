//
//  MakeProposalsView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 19/05/2022.
//

import SwiftUI

struct MakeProposalsView: View {
	@EnvironmentObject var session: FirebaseSession

	@State private var project: Project
	@State private var authorsNotes: String = ""
	@State var wordCount: String = ""
	@State private var errorMessage: String = ""
	@State var typeOfProject: [String] = [""]

	@Binding var shoeMakeProposalView: Bool

	var body: some View {
		NavigationView {
			VStack(spacing: 20) {
					Text("Select Project")
					QuestionSection(text: "Author's Notes", response: $authorsNotes)
					TextField("Word Count", text: $wordCount).textFieldStyle(RoundedBorderTextFieldStyle())
					SingleTagSelectView(chosenTag: $typeOfProject, questionLabel: "Type of Critique needed:", array: GlobalVariables.typeOfProject)
					ErrorText(errorMessage: errorMessage)
					StretchedButton(text: "Upload", action: {
						if authorsNotes == "" {
							errorMessage = "Please include some author's notes. These tell potential critiquers a bit more about what you're looking for in a critique"
						}
						if let wordCountNum = Int(wordCount) {
							session.newProposal(project: project, wordCount: wordCountNum, authorNotes: authorsNotes)
						} else {
							errorMessage = "Word count needs to be a number. Characters like k will not work."
						}
					})
			}.padding().navigationBarItems(
				trailing: Button(action: { self.shoeMakeProposalView.toggle() }) {
					Image(systemName: "pencil.tip.crop.circle.badge.plus")
				}).navigationBarTitle(Text("Request Critiques"), displayMode: .inline)
		}.accentColor(Color.darkText)
	}
}
