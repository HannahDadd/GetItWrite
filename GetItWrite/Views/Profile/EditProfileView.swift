//
//  EditProfileView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 05/05/2022.
//

import SwiftUI

struct EditProfileView: View {
	@EnvironmentObject var session: FirebaseSession

	@State private var displayName: String = ""
	@State private var bio: String = ""
	@State private var critiqueStyle: String = ""
	@State private var writing: String = ""
	@State private var authors: [String] = []
	@State private var writingGenres: [String] = []
	@State private var errorMessage: String = ""

	let colour: Int
	let rating: Int

	init(session: FirebaseSession) {
		if let user = session.userData {
			displayName = user.displayName
			bio = user.bio
			critiqueStyle = user.critiqueStyle
			writing = user.writing
			authors = user.authors
			writingGenres = user.writingGenres
			colour = user.colour
			rating = user.rating
		} else {
			colour = 1
			rating = 1
		}
	}

	var body: some View {
		ScrollView {
			VStack(spacing: 20) {
				Text("Edit Profile").font(.largeTitle).bold().frame(maxWidth: .infinity, alignment: .leading)
				TextField("Display name", text: $displayName).textFieldStyle(RoundedBorderTextFieldStyle())
				QuestionSection(text: "Bio", response: $bio)
				SelectTagView(chosenTags: $writingGenres, questionLabel: "What genres do you write?", array: GlobalVariables.genres)
				QuestionSection(text: "Writing", response: $writing)
				MakeTagsCloud(array: $authors, textLabel: "Add author", questionLabel: "Who are your favourite authors?")
				QuestionSection(text: "Critique style", response: $critiqueStyle)
				VStack {
					Text(errorMessage).foregroundColor(Color.red).fixedSize(horizontal: false, vertical: true)
					StretchedButton(text: "Save Changes", action: {
						if displayName == "" {
							errorMessage = "You must have a display name."
						} else if bio == "" {
							errorMessage = "Please tell others about yourself in your bio- this can be as simple as your favourite colour."
						} else if critiqueStyle == "" {
							errorMessage = "Please tell potential critique partners what your critique style is like. e.g. are you a line editer, grammar nut, more into overall feedback or all of them!"
						} else if writing == "" {
							errorMessage = "Please tell potential critique partners about your writing- what you like to write, any achievements and what you're currently working on."
						} else if authors == [] {
							errorMessage = "Please select at least one favourite author."
						} else if writingGenres == [] {
							errorMessage = "Please select at least one genre you like to write."
						} else {
							session.updateUser(newUser: User(id: session.user?.uid ?? "Error", displayName: displayName, bio: bio, photoURL: "", writing: writing, authors: authors, writingGenres: writingGenres, colour: colour, rating: rating, critiqueStyle: critiqueStyle))
						}
					})
				}
			}.padding()
		}
	}
}
