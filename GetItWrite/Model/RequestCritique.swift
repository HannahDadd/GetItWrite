//
//  RequestCritique.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 19/05/2022.
//

import Firebase
import SwiftUI

class RequestCritique: Hashable {

	let id: String
	let title: String
	let blurb: String
	let genres: [String]
	let triggerWarnings: [String]
	let workTitle: String
	let text: String
	let timestamp: Timestamp
	let writerId: String
	let writerName: String

	var dictionary: [String: Any?] {
		return ["title": title,
				"genres": genres,
				"text": text,
				"workTitle": workTitle,
				"blurb": blurb,
				"timestamp": timestamp,
				"triggerWarnings": triggerWarnings,
				"writerId": writerId,
				"writerName": writerName
		]
	}

	internal init(id: String, title: String, blurb: String, genres: [String], timestamp: Timestamp, writerName: String, writerId: String, workTitle: String, text: String, triggerWarnings: [String]) {
		self.id = id
		self.title = title
		self.genres = genres
		self.blurb = blurb
		self.timestamp = timestamp
		self.writerName = writerName
		self.writerId = writerId
		self.triggerWarnings = triggerWarnings
		self.workTitle = workTitle
		self.text = text
	}
}

extension RequestCritique {
	convenience init?(dictionary: [String: Any], id: String) {

		guard let title = dictionary["title"] as? String,
			  let genres = dictionary["genres"] as? [String],
			  let blurb = dictionary["blurb"] as? String,
			  let writerId = dictionary["writerId"] as? String,
			  let workTitle = dictionary["workTitle"] as? String,
			  let text = dictionary["text"] as? String,
			  let writerName = dictionary["writerName"] as? String,
			  let triggerWarnings = dictionary["triggerWarnings"] as? [String],
			  let timestamp = dictionary["timestamp"] as? Timestamp
		else { return nil }

		self.init(id: id, title: title, blurb: blurb, genres: genres, timestamp: timestamp, writerName: writerName, writerId: writerId, workTitle: workTitle, text: text, triggerWarnings: triggerWarnings)
	}

	static func == (lhs: RequestCritique, rhs: RequestCritique) -> Bool {
		return lhs.id == rhs.id
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}

	func formatDate() -> String {
		let formatter = RelativeDateTimeFormatter()
		formatter.unitsStyle = .short
		return formatter.localizedString(for: timestamp.dateValue(), relativeTo: Date())
	}
}
