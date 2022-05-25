//
//  ChatView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 22/05/2022.
//

import SwiftUI

struct ChatView: View {
	@EnvironmentObject var session: FirebaseSession
	@State private var result: Result<[Chat], Error>?

	var body: some View {
		switch result {
		case .success(let chats):
				ScrollView {
					ForEach(chats, id: \.self) { i in
						MessagePreview(chat: i)
					}
				}.navigationBarTitle(Text("Messages"), displayMode: .inline)
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
