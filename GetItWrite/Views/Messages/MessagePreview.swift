//
//  MessagePreview.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 22/05/2022.
//

import SwiftUI

struct MessagePreview: View {
	@EnvironmentObject var session: FirebaseSession
	let chat: Chat?
	@State private var result: Result<User, Error>?
	
	var body: some View {
		switch result {
		case .success(let user):
			NavigationLink(destination: MessagesView(user2Id: user.id, user2Username: user.displayName).environmentObject(session)) {
				HStack {
					ProfileImage(username: user.displayName, colour: user.colour)
					VStack(alignment: .leading) {
						Text(user.displayName).bold()
					}
					Spacer()
				}.padding()
			}
		case .failure(let error):
			ErrorView(error: error, retryHandler: loadSecondUser)
		case nil:
			HStack {
				Image(systemName: "person.crop.circle")
				Text(chat?.users.joined(separator: " ") ?? "").bold()
				Spacer()
			}.padding()
				.onAppear(perform: loadSecondUser)
		}
	}
	
	private func loadSecondUser() {
		guard let secondUser = chat?.users.filter({ $0 != session.userData?.id }).first else { return }
		session.getUserFromId(id: secondUser) {
			result = $0
		}
	}
}
