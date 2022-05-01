//
//  User.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/02/2022.
//

import Foundation

class User: Identifiable {

    let id: String
    let displayName: String
    let bio: String
    let photoURL: String
    let writing: String
    let authors: [String]
    let writingGenres: [String]
	let colour: Int
	var rating: Int

    var dictionary: [String: Any?] {
        return ["displayName": displayName,
                "bio": bio,
                "photoURL": photoURL,
                "writing": writing,
                "authors": authors,
                "writingGenres": writingGenres,
				"colour": colour,
				"rating": rating
        ]
    }

	init(id: String, displayName: String, bio: String,  photoURL: String, writing: String, authors: [String], writingGenres: [String], colour: Int, rating: Int) {
        self.id = id
        self.displayName = displayName
        self.bio = bio
        self.photoURL = photoURL
        self.writing = writing
        self.authors = authors
        self.writingGenres = writingGenres
		self.colour = colour
		self.rating = rating
    }
}

extension User {
    convenience init?(dictionary: [String: Any], id: String) {

		guard let bio = dictionary["bio"] as? String,
			  let displayName = dictionary["displayName"] as? String,
			  let photoURL = dictionary["photoURL"] as? String,
			  let writing = dictionary["writing"] as? String,
			  let authors = dictionary["authors"] as? [String],
			  let writingGenres = dictionary["writingGenres"] as? [String],
			  let colour = dictionary["colour"] as? Int,
			  let rating = dictionary["rating"] as? Int
		else { return nil }

		self.init(id: id, displayName: displayName, bio: bio,  photoURL: photoURL, writing: writing, authors: authors ?? [], writingGenres: writingGenres ?? [], colour: colour, rating: rating)
    }
}

