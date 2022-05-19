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
	var blurb: String
	var genres: [String]
	var triggerWarnings: [String]

    var body: some View {
		VStack {
			Text("Add text here:").bold().frame(maxWidth: .infinity, alignment: .leading)
			TextEditor(text: $text)
			ErrorText(errorMessage: errorMessage)
			StretchedButton(text: "Request Critique", action: {
				if text == "" {
					errorMessage = "Paste or type your project above."
				} else {
					session.newWork(title: title, text: text, blurb: blurb, genres: genres, triggerWarnings: triggerWarnings)
				 	showingComposeMessage.toggle()
				}
			})
		}.padding()
    }
}
