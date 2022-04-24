//
//  Critique.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 24/04/2022.
//

import Firebase
import CloudKit

class Critique {

	let id: String
	let comments: [Comment]
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

	internal init(id: String, comments: [Comment], posterImage: String, posterId: String, posterUsername: String, timestamp: Timestamp, overallFeedback: String) {
		self.id = id
		self.comments = comments
		self.posterImage = posterImage
		self.posterId = posterId
		self.posterUsername = posterUsername
		self.timestamp = timestamp
		self.overallFeedback = overallFeedback
	}
}

extension Critique {
	convenience init?(dictionary: [String: Any], id: String) {

		guard let comments = dictionary["comments"] as? [Comment],
			  let posterId = dictionary["posterId"] as? String,
			  let posterImage = dictionary["posterImage"] as? String,
			  let posterUsername = dictionary["posterUsername"] as? String,
			  let timestamp = dictionary["timestamp"] as? Timestamp,
			  let overallFeedback = dictionary["overallFeedback"] as? String
		else { return nil }

		self.init(id: id, comments: comments, posterImage: posterImage, posterId: posterId, posterUsername: posterUsername, timestamp: timestamp, overallFeedback: overallFeedback)
	}
}
