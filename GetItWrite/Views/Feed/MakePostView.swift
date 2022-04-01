//
//  MakePostView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 01/04/2022.
//

import SwiftUI

struct MakePostView: View {
	@EnvironmentObject var session: FirebaseSession

	@State private var text: String = ""
	@State private var title: String = ""
	@State private var synopsisSoFar: String = ""
	@State var blurb: String = ""
	@State var genres: [String] = []
	@State var typeOfWork: String = ""
	@State private var midBook = true

	@Binding var showingComposeMessage: Bool

	var body: some View {
		ScrollView(.vertical) {
			VStack(spacing: 20) {
				QuestionSection(text: "Title", response: $title)
				QuestionSection(text: "Blurb", response: $blurb)
				SelectTagView(chosenTags: $genres, questionLabel: "Genre of piece?", array: GlobalVariables.genres)
				SingleTagSelectView(chosenTag: $typeOfWork, questionLabel: "Type of Work", array: GlobalVariables.typeOfWork)
				if typeOfWork == GlobalVariables.typeOfWork[1] {
					Toggle("Is this mid book?", isOn: $midBook)
					if midBook {
						Text("Add a synopsis of any required information for your reader to understand the chapter").bold()
						TextEditor(text: $synopsisSoFar)
							.frame(height: 100, alignment: .leading)
							.cornerRadius(6.0)
							.border(Color.gray, width: 1)
							.multilineTextAlignment(.leading)
					}
				}
				StretchedButton(text: "POST", action: {
					self.session.post(title: title, text: text, synopsisSoFar: synopsisSoFar, typeOfWork: typeOfWork, blurb: blurb, genres: genres)
					self.showingComposeMessage.toggle()
				})
			}
		}.padding().navigationBarItems(
			leading: Button(action: { self.showingComposeMessage.toggle() }) {
				Text("Cancel")
			}
		).navigationBarTitle(Text("New Post"), displayMode: .inline)
	}
}
