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
	@State var blurb: String = ""
	@State var genres: [String] = []
	@State var triggerWarnings: [String] = []
	@State var typeOfProject: [String] = [""]

	@State private var midBook = true
	@State private var errorMessage: String = ""
	@State var changePage = false

	@Binding var shoeMakeProposalView: Bool

	var body: some View {
		NavigationView {
			VStack(spacing: 20) {
					Text("Select Project")
					QuestionSection(text: "Author's Notes", response: $authorsNotes)
					ErrorText(errorMessage: errorMessage)
					StretchedButton(text: "Upload", action: {
						if authorsNotes == "" {
							errorMessage = "Please include some author's notes. These tell potential critiquers a bit more about what you're looking for in a critique"
						} else if typeOfProject == [""] {
							errorMessage = "Please choose what type of project this is."
						} else if blurb == "" {
							errorMessage = "Please include a blurb. This tells potential critiquers what your project is about- it can be as informal as you like."
						} else if genres == [] {
							errorMessage = "Please select at least one genre for your project."
						} else {
							changePage = true
						}
					})
			}.padding().navigationBarItems(
				trailing: Button(action: { self.shoeMakeProposalView.toggle() }) {
					Image(systemName: "pencil.tip.crop.circle.badge.plus")
				}).navigationBarTitle(Text("Request Critiques"), displayMode: .inline)
		}.accentColor(Color.darkText)
	}
}
