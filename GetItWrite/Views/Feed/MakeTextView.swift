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

	@Binding var showingComposeMessage: Bool

	var title: String
	var synopsisSoFar: String
	var blurb: String
	var genres: [String]
	var typeOfWork: String

    var body: some View {
		VStack {
			Text("Add work here:").bold().frame(maxWidth: .infinity, alignment: .leading)
			TextEditor(text: $text)
			ErrorText(errorMessage: errorMessage)
			StretchedButton(text: "Request Critique", action: {
				if text == "" {
					errorMessage = "Paste or type your work above."
				} else {
					session.post(title: title, text: text, synopsisSoFar: synopsisSoFar, typeOfWork: typeOfWork, blurb: blurb, genres: genres)
				 showingComposeMessage.toggle()
				}
			})
		}.padding()
    }
}
