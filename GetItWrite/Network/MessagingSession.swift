//
//  MessagingSession.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 22/05/2022.
//

import SwiftUI
import FirebaseFirestore

extension FirebaseSession {

	func loadAllChats(completion: @escaping (Result<[Chat], Error>) -> Void) {
		guard let userData = self.userData else { return }

		Firestore.firestore().collection("chats").whereField("users", arrayContains: userData.id).addSnapshotListener { (snap, err) in
			if let error = err {
				completion(.failure(error))
			} else {
				let chatValues = snap?.documents.map { Chat(dictionary: $0.data()) }.compactMap ({ $0 })
				completion(.success(chatValues ?? []))
			}
		}
	}

	func loadChat(user2UID: String, completion: @escaping (Result<(String, [Message]), Error>) -> Void) {
		guard let userData = self.userData else { return }

		Firestore.firestore().collection("chats").whereField("users", arrayContains: userData.id).getDocuments { (chatQuerySnap, error) in
			if let error = error {
				completion(.failure(error))
			} else {
				guard let queryCount = chatQuerySnap?.documents.count else { return }

				if queryCount == 0 {
					self.createNewChat(user2UID: user2UID, completion: completion)
				} else {

					for doc in chatQuerySnap!.documents {
						if let chat = Chat(dictionary: doc.data()) {
							if (chat.users.contains(user2UID)) {

								doc.reference.collection("messages")
									.order(by: "created", descending: false)
									.addSnapshotListener(includeMetadataChanges: true, listener: { (threadQuery, error) in
										if let error = error {
											completion(.failure(error))
											return
										} else {
											let newMessages = threadQuery!.documents.map { Message(dictionary: $0.data()) }.compactMap ({ $0 })
											completion(.success((doc.documentID, newMessages)))
											return
										}
									})
								completion(.success((doc.documentID, [])))
								return
							}
						}
					}
					self.createNewChat(user2UID: user2UID, completion: completion)
				}
			}
		}
	}

	func sendMessage(content: String, chatId: String) {
		guard let userData = self.userData else { return }

		Firestore.firestore().collection("chats").document(chatId).collection("messages").document().setData(["content": content, "senderId": userData.id, "created": FieldValue.serverTimestamp()]) { (err) in
			if err != nil { print(err.debugDescription) }
		}
	}

	private func createNewChat(user2UID: String, completion: @escaping (Result<(String, [Message]), Error>) -> Void) {
		guard let userData = self.userData else { return }

		Firestore.firestore().collection("chats").document().setData(["users": [userData.id, user2UID]]) { (error) in
			if let error = error {
				completion(.failure(error))
			} else {
				self.loadChat(user2UID: user2UID, completion: completion)
			}
		}
	}
}
