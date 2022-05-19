//
//  MakeProposalsView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 19/05/2022.
//

import SwiftUI

struct MakeProposalsView: View {
	@EnvironmentObject var session: FirebaseSession
	
	@State private var project: Project? = nil
	@State private var authorsNotes: String = ""
	@State var wordCount: String = ""
	@State private var errorMessage: String = ""
	@State var typeOfProject: [String] = [""]
	
	@Binding var showMakeProposalView: Bool
	
	var body: some View {
		NavigationView {
			ScrollView {
				VStack(spacing: 20) {
					if let project = project {
						ProjectView(project: project)
					} else {
						NavigationLink(destination: SelectProjectView(project: $project).environmentObject(session)) {
							Text("Select Project")
						}
					}
					QuestionSection(text: "Author's Notes", response: $authorsNotes)
					TextField("Word Count", text: $wordCount).textFieldStyle(RoundedBorderTextFieldStyle())
					SingleTagSelectView(chosenTag: $typeOfProject, questionLabel: "What do you need Critiquing:", array: GlobalVariables.typeOfProject)
					Spacer()
					ErrorText(errorMessage: errorMessage)
					StretchedButton(text: "Upload", action: {
						if authorsNotes == "" {
							errorMessage = "Please include some author's notes. These tell potential critiquers a bit more about what you're looking for in a critique"
						} else if typeOfProject == [""] {
							errorMessage = "Please choose what you need critiquing."
						} else if let wordCountNum = Int(wordCount) {
							if let chosenProject = project {
								session.newProposal(project: chosenProject, wordCount: wordCountNum, authorNotes: authorsNotes, typeOfProject: typeOfProject[0])
							} else {
								errorMessage = "Please select a project to receive a critique for."
							}
						} else {
							errorMessage = "Word count needs to be a number. Characters like k will not work."
						}
					})
				}.padding()
			}.navigationBarItems(
				trailing: Button(action: { self.showMakeProposalView.toggle() }) {
					Text("Cancel")
				}).navigationBarTitle(Text("Request Critiques"), displayMode: .inline)
		}.accentColor(Color.darkText)
	}
}
