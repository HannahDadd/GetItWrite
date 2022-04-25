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
					NavigationLink("Next", destination: MakeTextView(showingComposeMessage: $showingComposeMessage, title: title, synopsisSoFar: synopsisSoFar, blurb: blurb, genres: genres, typeOfWork: typeOfWork))
				}
			}.padding().navigationBarItems(
				trailing: Button(action: { self.showingComposeMessage.toggle() }) {
					Text("Cancel")
				}).navigationBarTitle(Text("New Work"), displayMode: .inline)
		}
	}
}
