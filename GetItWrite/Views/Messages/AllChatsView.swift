//
//  ChatView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 22/05/2022.
//

import SwiftUI

struct AllChatsView: View {
	@EnvironmentObject var session: FirebaseSession
	@State private var result: Result<[Chat], Error>?

	var body: some View {
		switch result {
		case .success(let chats):
			List {
				if chats.count == 0 {
					VStack(alignment: .leading, spacing: 24) {
						Text("You have no chats.").font(.title2)
						Text("Select 'Swap' on the side bar 👈 to find critique partners.")
					}
				}
				ForEach(chats, id: \.self) { i in
					MessagePreview(chat: i)
				}
			}.refreshable {
				loadChats()
			}.listStyle(.plain).navigationBarTitle(Text("Messages"), displayMode: .inline)
		case .failure(let error):
			if error.localizedDescription.contains("The query requires an index. You can create it here:") {
				VStack {
					Text("No Chats yet").font(.caption)
				}
			} else {
				ErrorView(error: error, retryHandler: loadChats)
			}
		case nil:
			ProgressView().onAppear(perform: loadChats)
		}
	}

	private func loadChats() {
		session.loadAllChats {
			result = $0
		}
	}
}
