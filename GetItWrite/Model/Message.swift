//
//  Message.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 22/05/2022.
//

import Firebase

struct Message: Identifiable, Hashable {

	let id = UUID()
	var content: String
	var created: Timestamp
	var senderID: String

	var dictionary: [String: Any] {
		return [
			"content": content,
			"created": created,
			"senderId": senderID
		]
	}
}

extension Message {
	init?(dictionary: [String: Any]) {

		guard let content = dictionary["content"] as? String,
			let created = dictionary["created"] as? Timestamp,
			let senderID = dictionary["senderId"] as? String
			else { return nil }

		self.init(content: content, created: created, senderID: senderID)
	}

	func formatDate() -> String {
		let formatter = RelativeDateTimeFormatter()
		formatter.unitsStyle = .short
		return formatter.localizedString(for: created.dateValue(), relativeTo: Date())
	}
}
