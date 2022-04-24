//
//  Comment.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 24/04/2022.
//

import Firebase

class Comment {

	let id: String
	let comment: String
	let word: String
	let instance: Int

	var dictionary: [String: Any?] {
		return [
			"comment": comment,
			"word": word,
			"instance": instance
		]
	}

	internal init(id: String, comment: String, word: String, instance: Int) {
		self.id = id
		self.comment = comment
		self.word = word
		self.instance = instance
	}
}

extension Comment {
	convenience init?(dictionary: [String: Any], id: String) {

		guard let comment = dictionary["comment"] as? String,
			  let word = dictionary["word"] as? String,
			  let instance = dictionary["instance"] as? Int
			else { return nil }

		self.init(id: id, comment: comment, word: word, instance: instance)
	}
}
