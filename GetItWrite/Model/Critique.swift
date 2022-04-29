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
	let critiquerId: String
	let critiquerName: String
	let critiquerProfileColour: Int
	let timestamp: Timestamp

	var dictionary: [String: Any?] {
		return [
			"comments": comments,
			"overallFeedback": overallFeedback,
			"critiquerId": critiquerId,
			"critiquerName": critiquerName,
			"critiquerProfileColour": critiquerProfileColour,
			"timestamp": timestamp
		]
	}
}

extension Critique {
	init?(dictionary: [String: Any], id: String) {

		guard let critiquerId = dictionary["critiquerId"] as? String,
			  let critiquerName = dictionary["critiquerName"] as? String,
			  let timestamp = dictionary["timestamp"] as? Timestamp,
			  let overallFeedback = dictionary["overallFeedback"] as? String,
			  let critiquerProfileColour = dictionary["critiquerProfileColour"] as? Int,
			  let comments = dictionary["comments"] as? [String: Int]
		else { return nil }

		self.init(id: id, comments: comments, overallFeedback: overallFeedback, critiquerId: critiquerId, critiquerName: critiquerName, critiquerProfileColour: critiquerProfileColour, timestamp: timestamp)
	}

	func formatDate() -> String {
		let formatter = RelativeDateTimeFormatter()
		formatter.unitsStyle = .short
		return formatter.localizedString(for: timestamp.dateValue(), relativeTo: Date())
	}
}
