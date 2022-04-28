//
//  Critique.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 24/04/2022.
//

import Firebase
import CloudKit

struct Critique {

	let id: String
	let comments: [String: Int]
	let overallFeedback: String
	let posterImage: String
	let posterId: String
	let posterUsername: String
	let timestamp: Timestamp

	var dictionary: [String: Any?] {
		return [
			"comments": comments,
			"overallFeedback": overallFeedback,
			"posterImage": posterImage,
			"posterId": posterId,
			"posterUsername": posterUsername,
			"timestamp": timestamp
		]
	}
}

extension Critique {
	init?(dictionary: [String: Any], id: String) {

		guard let posterId = dictionary["posterId"] as? String,
			  let posterImage = dictionary["posterImage"] as? String,
			  let posterUsername = dictionary["posterUsername"] as? String,
			  let timestamp = dictionary["timestamp"] as? Timestamp,
			  let overallFeedback = dictionary["overallFeedback"] as? String,
			  let comments = dictionary["comments"] as? [String: Int]
		else { return nil }

		self.init(id: id, comments: comments, overallFeedback: overallFeedback, posterImage: posterImage, posterId: posterId, posterUsername: posterUsername, timestamp: timestamp)
	}

	func formatDate() -> String {
		let formatter = RelativeDateTimeFormatter()
		formatter.unitsStyle = .short
		return formatter.localizedString(for: timestamp.dateValue(), relativeTo: Date())
	}
}
