//
//  MakePostView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 01/04/2022.
//

import SwiftUI

struct MakePostView: View {
	@EnvironmentObject var session: FirebaseSession

	@State private var title: String = ""
	@State private var synopsisSoFar: String = ""
	@State var blurb: String = ""
	@State var genres: [String] = []
	@State var typeOfWork: String = ""

	@State private var midBook = true
	@State private var errorMessage: String = ""
	@State var changePage = false

	@Binding var showingComposeMessage: Bool

	var body: some View {
		NavigationView {
			ScrollView(.vertical) {
				VStack(spacing: 20) {
					TextField("Title", text: $title).textFieldStyle(RoundedBorderTextFieldStyle())
					SingleTagSelectView(chosenTag: $typeOfWork, questionLabel: "Type of Work:", array: GlobalVariables.typeOfWork)
					if typeOfWork == GlobalVariables.typeOfWork[2] {
						Toggle("Is this mid book?", isOn: $midBook).tint(.lightBackground)
						if midBook {
							QuestionSection(text: "Add a synopsis of any required information for your reader to understand the chapter", response: $synopsisSoFar)
						}
					}
					QuestionSection(text: "Blurb", response: $blurb)
					SelectTagView(chosenTags: $genres, questionLabel: "Genre of piece:", array: GlobalVariables.genres)
					ErrorText(errorMessage: errorMessage)
					StretchedButton(text: "Request Critique", action: {
						if title == "" {
							errorMessage = "Your work needs a title!"
						} else if typeOfWork == "" {
							errorMessage = "Please choose what type of work this is."
						} else if blurb == "" {
							errorMessage = "Please include a blurb. This tells potential critiquers what your work is about- it can be as informal as you like."
						} else {
							changePage = true
						}
					})
					NavigationLink(destination: MakeTextView(showingComposeMessage: $showingComposeMessage, title: title, synopsisSoFar: synopsisSoFar, blurb: blurb, genres: genres, typeOfWork: typeOfWork).environmentObject(session), isActive: self.$changePage) {
					 EmptyView()
				 }
				}
			}.padding().navigationBarItems(
				trailing: Button(action: { self.showingComposeMessage.toggle() }) {
					Text("Cancel")
				}).navigationBarTitle(Text("New Work"), displayMode: .inline)
		}
	}
}
