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
	@State var blurb: String = ""
	@State var genres: [String] = []

	@Binding var showingComposeMessage: Bool

	var body: some View {
		ScrollView(.vertical) {
			VStack(spacing: 20) {
				Text("Blurb").bold()
				TextEditor(text: $text)
					.frame(height: 100, alignment: .leading)
					.cornerRadius(6.0)
					.border(Color.gray, width: 1)
					.multilineTextAlignment(.leading)
				Text("You may only post in interests you follow").font(.caption)
				TagCloud(tags: session.session?.userData?.interests ?? [], onTap: { text in
					self.interest = text
				})
				Text("Chosen topic: \(self.interest)")
				HStack {
					Button(action: {
						self.session.post(text: self.text, interest: self.interest, imageUrl: self.imageURL)
						self.showingComposeMessage.toggle()
					}) {
						Text("Post").bold()
					}
					Spacer()
					Button(action: { self.showingComposeMessage.toggle() }) {
						Text("Cancel")
					}
				}
				Spacer()
			}
		}.padding().navigationBarItems(
			leading: Button(action: { self.showingComposeMessage.toggle() }) {
				Text("Cancel")
			}
		).navigationBarTitle(Text("New Post"), displayMode: .inline)
	}
}
