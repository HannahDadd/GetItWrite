//
//  Critique.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 24/04/2022.
//

import Firebase
import CloudKit

struct Critique: UserGeneratedContent {

	let id: String
	let comments: [String: Int]
	let overallFeedback: String
	let critiquerId: String
	let text: String
	let title: String
	let projectTitle: String
	let critiquerName: String
	let critiquerProfileColour: Int
	let timestamp: Timestamp
	var rated: Bool

	var dictionary: [String: Any?] {
		return [
			"comments": comments,
			"text": text,
			"projectTitle": projectTitle,
			"title": title,
			"overallFeedback": overallFeedback,
			"critiquerId": critiquerId,
			"critiquerName": critiquerName,
			"critiquerProfileColour": critiquerProfileColour,
			"timestamp": timestamp,
			"rated": rated
		]
	}
}

extension Critique {
	init?(dictionary: [String: Any], id: String) {

		guard let critiquerId = dictionary["critiquerId"] as? String,
			  let critiquerName = dictionary["critiquerName"] as? String,
			  let text = dictionary["text"] as? String,
			  let projectTitle = dictionary["projectTitle"] as? String,
			  let title = dictionary["title"] as? String,
			  let timestamp = dictionary["timestamp"] as? Timestamp,
			  let overallFeedback = dictionary["overallFeedback"] as? String,
			  let critiquerProfileColour = dictionary["critiquerProfileColour"] as? Int,
			  let comments = dictionary["comments"] as? [String: Int],
			  let rated = dictionary["rated"] as? Bool
		else { return nil }

		self.init(id: id, comments: comments, overallFeedback: overallFeedback, critiquerId: critiquerId, text: text, title: title, projectTitle: projectTitle, critiquerName: critiquerName, critiquerProfileColour: critiquerProfileColour, timestamp: timestamp, rated: rated)
	}

	func formatDate() -> String {
		let formatter = RelativeDateTimeFormatter()
		formatter.unitsStyle = .short
		return formatter.localizedString(for: timestamp.dateValue(), relativeTo: Date())
	}
}
