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
    @State private var chatWithSelf = false
	
	var body: some View {
		switch result {
		case .success(let user):
            if let hasBlockedUser = session.userData?.blockedUserIds.contains(user.id), hasBlockedUser {
                EmptyView()
            } else {
                NavigationLink(destination: MessagesView(user2Id: user.id, user2Username: user.displayName).environmentObject(session)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(user.displayName)
                                .font(.headline)
                        }
                        Spacer()
                    }.padding()
                }
            }
		case .failure(let error):
            HStack {
                Text("Failed to load chat due to \(error.localizedDescription). The users account may have been deleted.").bold()
                Spacer()
            }
		case nil:
            if chatWithSelf {
                HStack {
                    Text("You cannot make a chat with yourself.").bold()
                    Spacer()
                }
            } else {
                EmptyView()
                    .onAppear(perform: loadSecondUser)
            }
		}
	}
	
	private func loadSecondUser() {
		guard let secondUser = chat?.users.filter({ $0 != session.userData?.id }).first else {
            chatWithSelf = true
            return
        }
		session.getUserFromId(id: secondUser) {
			result = $0
		}
	}
}
