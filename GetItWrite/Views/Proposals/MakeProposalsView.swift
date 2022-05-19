//
//  MakeProposalsView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 19/05/2022.
//

import SwiftUI

struct MakeProposalsView: View {
	@EnvironmentObject var session: FirebaseSession

	@State private var title: String = ""
	@State private var synopsisSoFar: String = ""
	@State var blurb: String = ""
	@State var genres: [String] = []
	@State var triggerWarnings: [String] = []
	@State var typeOfProject: [String] = [""]

	@State private var midBook = true
	@State private var errorMessage: String = ""
	@State var changePage = false

	@Binding var showingComposeMessage: Bool

	var body: some View {
		NavigationView {
			VStack(spacing: 20) {
					Text("Select ")
					QuestionSection(text: "Blurb", response: $blurb)
					SelectTagView(chosenTags: $genres, questionLabel: "Genre of piece:", array: GlobalVariables.genres)
					MakeTagsCloud(array: $triggerWarnings, textLabel: "Add warnings", questionLabel: "Add any trigger warnings for your project here.")
					ErrorText(errorMessage: errorMessage)
					StretchedButton(text: "Upload", action: {
						if title == "" {
							errorMessage = "Your project needs a title!"
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
					NavigationLink(destination: MakeTextView(showingComposeMessage: $showingComposeMessage, title: title, synopsisSoFar: synopsisSoFar, blurb: blurb, genres: genres, triggerWarnings: triggerWarnings, typeOfProject: typeOfProject[0]).environmentObject(session), isActive: self.$changePage) {
						EmptyView()
					}
			}.padding().navigationBarItems(
				trailing: Button(action: { self.showingComposeMessage.toggle() }) {
					Image(systemName: "pencil.tip.crop.circle.badge.plus")
				}).navigationBarTitle(Text("Request Critiques"), displayMode: .inline)
		}.accentColor(Color.darkText)
	}
}
