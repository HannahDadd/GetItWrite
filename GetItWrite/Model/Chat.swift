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

	var dictionary: [String: Any] {
		return ["users": users]
	}
}

extension Chat {
	init?(dictionary: [String: Any]) {
		guard let chatUsers = dictionary["users"] as? [String] else { return nil }
		self.init(users: chatUsers)
	}
}
