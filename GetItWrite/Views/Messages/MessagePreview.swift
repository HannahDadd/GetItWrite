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
                HStack {
                    Image(systemName: "person.crop.circle")
                    Text("User is blocked.").bold()
                    Spacer()
                }
            } else {
                NavigationLink(destination: MessagesView(user2Id: user.id, user2Username: user.displayName).environmentObject(session)) {
                    HStack {
                        ProfileImage(username: user.displayName, colour: user.colour)
                        VStack(alignment: .leading) {
                            Text(user.displayName).bold()
                        }
                        Spacer()
                    }.padding()
                }
            }
		case .failure(let error):
            HStack {
                Image(systemName: "person.crop.circle")
                Text("Failed to load chat due to \(error.localizedDescription). The users account may have been deleted.").bold()
                Spacer()
            }
		case nil:
            if chatWithSelf {
                HStack {
                    Image(systemName: "person.crop.circle")
                    Text("You cannot make a chat with yourself.").bold()
                    Spacer()
                }
            } else {
                HStack {
                    Image(systemName: "person.crop.circle")
                    Text("Loading...").bold()
                    Spacer()
                }.padding()
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
