//
//  MakePostView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 01/04/2022.
//

import SwiftUI

struct MakeProjectView: View {
	@EnvironmentObject var session: FirebaseSession

	@State private var title: String = ""
	@State var blurb: String = ""
	@State var genres: [String] = []
	@State var triggerWarnings: [String] = []
	@State private var errorMessage: String = ""

	@Binding var project: Project?

	var body: some View {
		ScrollView(.vertical) {
			VStack(spacing: 20) {
				TextField("Title", text: $title).textFieldStyle(RoundedBorderTextFieldStyle())
				QuestionSection(text: "Blurb", response: $blurb)
				SelectTagView(chosenTags: $genres, questionLabel: "Genre of piece:", array: GlobalVariables.genres)
				MakeTagsCloud(array: $triggerWarnings, textLabel: "Add warnings", questionLabel: "Add any trigger warnings for your project here.")
				ErrorText(errorMessage: errorMessage)
				StretchedButton(text: "Upload", action: {
					if title == "" {
						errorMessage = "Your project needs a title!"
					} else if blurb == "" {
						errorMessage = "Please include a blurb. This tells potential critiquers what your project is about- it can be as informal as you like."
					} else if genres == [] {
						errorMessage = "Please select at least one genre for your project."
					} else {
						session.newProject(title: title, blurb: blurb, genres: genres, triggerWarnings: triggerWarnings)
						// TODO: Move back to make propsoal view here
					}
				})
			}.padding().navigationBarTitle(Text("Create a Project"), displayMode: .inline)
		}
	}
}
