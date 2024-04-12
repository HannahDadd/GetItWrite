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
					let c = chatQuerySnap!.documents.map { ($0, Chat(dictionary: $0.data())) }.filter { doc, chat in
						if let chat = chat {
							return chat.users.contains(user2UID)
						}
						return false
					}

					if c.count == 0 {
						self.createNewChat(user2UID: user2UID, completion: completion)
					} else {
						let doc = c[0].0
						doc.reference.collection("messages")
							.order(by: "created", descending: false)
							.addSnapshotListener(includeMetadataChanges: true, listener: { (threadQuery, error) in
								if let error = error {
									completion(.failure(error))
								} else {
									let newMessages = threadQuery!.documents.map { Message(dictionary: $0.data()) }.compactMap ({ $0 })
									completion(.success((doc.documentID, newMessages)))
								}
							})
						completion(.success((doc.documentID, [])))
					}
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
    
    func sendReply(content: String, questionId: String) {
        guard let userData = self.userData else { return }
        let reply = Reply(reply: content, replierId: userData.id, replierName: userData.displayName, replierColour: userData.colour, timestamp: Timestamp())

        Firestore.firestore().collection("questions").document(questionId).collection("replies").document(reply.id).setData(reply.dictionary as [String : Any]) { (err) in
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
