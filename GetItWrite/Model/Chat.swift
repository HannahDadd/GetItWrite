//
//  Chat.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 22/05/2022.
//

import Foundation

struct Chat: Identifiable, Hashable {

	let id = UUID()
	var users: [String]
	var messages: [Message]

	var dictionary: [String: Any] {
		return ["users": users,
				"messages": messages]
	}
}

extension Chat {
	init?(dictionary: [String: Any]) {
		guard let chatUsers = dictionary["users"] as? [String],
			  let messages = dictionary["messages"] as? [Message] else { return nil }
		self.init(users: chatUsers, messages: messages)
	}
}
