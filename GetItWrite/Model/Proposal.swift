//
//  Proposal.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 16/05/2022.
//

import Firebase
import SwiftUI

class Proposal: Hashable {

	let id: String
	let title: String
	let typeOfProject: String
	let blurb: String
	let genres: [String]
	let triggerWarnings: [String]
	let timestamp: Timestamp
	let authorNotes: String
	let wordCount: Int
	let writerId: String
	let writerName: String

	var dictionary: [String: Any?] {
		return [
			"title": title,
			"genres": genres,
			"typeOfProject": typeOfProject,
			"authorNotes": authorNotes,
			"blurb": blurb,
			"timestamp": timestamp,
			"triggerWarnings": triggerWarnings,
			"wordCount": wordCount,
			"writerId": writerId,
			"writerName": writerName
		]
	}

	internal init(id: String, title: String, typeOfProject: String, blurb: String, genres: [String], timestamp: Timestamp, writerName: String, writerId: String, triggerWarnings: [String], wordCount: Int, authorNotes: String) {
		self.id = id
		self.title = title
		self.typeOfProject = typeOfProject
		self.genres = genres
		self.blurb = blurb
		self.timestamp = timestamp
		self.writerName = writerName
		self.writerId = writerId
		self.triggerWarnings = triggerWarnings
		self.wordCount = wordCount
		self.authorNotes = authorNotes
	}
}

extension Proposal {
	convenience init?(dictionary: [String: Any], id: String) {

		guard let title = dictionary["title"] as? String,
			  let typeOfProject = dictionary["typeOfProject"] as? String,
			  let genres = dictionary["genres"] as? [String],
			  let blurb = dictionary["blurb"] as? String,
			  let writerId = dictionary["writerId"] as? String,
			  let writerName = dictionary["writerName"] as? String,
			  let authorsNotes = dictionary["authorsNotes"] as? String,
			  let wordCount = dictionary["wordCount"] as? Int,
			  let triggerWarnings = dictionary["triggerWarnings"] as? [String],
			  let timestamp = dictionary["timestamp"] as? Timestamp
		else { return nil }

		self.init(id: id, title: title, typeOfProject: typeOfProject, blurb: blurb, genres: genres, timestamp: timestamp, writerName: writerName, writerId: writerId, triggerWarnings: triggerWarnings, wordCount: wordCount, authorsNotes: authorsNotes)
	}

	static func == (lhs: Proposal, rhs: Proposal) -> Bool {
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

