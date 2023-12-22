//
//  Project.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 20/02/2022.
//

import Firebase
import SwiftUI

class Project: Hashable, UserGeneratedContent {
	
	let id: String
	let title: String
	let blurb: String
	let genres: [String]
	let triggerWarnings: [String]
	let timestamp: Timestamp
	let writerId: String
	let writerName: String
	
	var dictionary: [String: Any?] {
		return ["title": title,
			"genres": genres,
			"blurb": blurb,
			"timestamp": timestamp,
			"triggerWarnings": triggerWarnings,
			"writerId": writerId,
			"writerName": writerName
		]
	}
	
	internal init(id: String, title: String, blurb: String, genres: [String], timestamp: Timestamp, writerName: String, writerId: String, triggerWarnings: [String]) {
		self.id = id
		self.title = title
		self.genres = genres
		self.blurb = blurb
		self.timestamp = timestamp
		self.writerName = writerName
		self.writerId = writerId
		self.triggerWarnings = triggerWarnings
	}
}

extension Project {
	convenience init?(dictionary: [String: Any], id: String) {
		
		guard let title = dictionary["title"] as? String,
			  let genres = dictionary["genres"] as? [String],
			  let blurb = dictionary["blurb"] as? String,
			  let writerId = dictionary["writerId"] as? String,
			  let writerName = dictionary["writerName"] as? String,
			  let triggerWarnings = dictionary["triggerWarnings"] as? [String],
			  let timestamp = dictionary["timestamp"] as? Timestamp
		else { return nil }
		
		self.init(id: id, title: title, blurb: blurb, genres: genres, timestamp: timestamp, writerName: writerName, writerId: writerId, triggerWarnings: triggerWarnings)
	}
	
	static func == (lhs: Project, rhs: Project) -> Bool {
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
