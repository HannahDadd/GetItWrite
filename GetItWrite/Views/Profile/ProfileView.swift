//
//  ProfileView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 20/05/2022.
//

import SwiftUI

struct ProfileView: View {
	@EnvironmentObject var session: FirebaseSession
	@State private var result: Result<User, Error>?

	let id: String

	var body: some View {
		switch result {
		case .success(let user):
			ScrollView {
				VStack(spacing: 25) {
					Text(session.userData?.displayName ?? "").font(.title)
					TextAndHeader(heading: "Bio", text: user.bio)
					TextAndTags(heading: "Favourite Authors", tags: user.authors)
					TextAndHeader(heading: "Writing", text: user.writing)
					TextAndTags(heading: "Writing Genres", tags: user.writingGenres)
					TextAndHeader(heading: "Critique Style", text: user.critiqueStyle)
				}.padding()
			}
		case .failure(let error):
			ErrorView(error: error, retryHandler: loadUser)
		case nil:
			ProgressView().onAppear(perform: loadUser)
		}
	}

	private func loadUser() {
		session.getUserFromId(id: id) {
			result = $0
		}
	}
}
