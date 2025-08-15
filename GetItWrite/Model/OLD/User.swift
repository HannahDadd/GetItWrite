//
//  User.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/02/2022.
//

import Foundation
import Firebase

class User: Identifiable {
    let id: String
    let displayName: String
    var bio: String
    var photoURL: String
    var writing: String
    var critiqueStyle: String
    var authors: [String]
    var writingGenres: [String]
    var colour: Int
	var rating: Int
    var blockedUserIds: [String]
    var lastCritique: Timestamp?
    var lastFiveCritiques: [Timestamp]?
    var frequencey: Double?
    var critiquerExpected: String?

    var dictionary: [String: Any?] {
        return ["displayName": displayName,
                "bio": bio,
                "photoURL": photoURL,
                "writing": writing,
                "authors": authors,
                "writingGenres": writingGenres,
				"colour": colour,
				"rating": rating,
				"critiqueStyle": critiqueStyle,
                "blockedUserIds": blockedUserIds,
                "lastCritique": lastCritique,
                "lastFiveCritiques": lastFiveCritiques,
                "frequencey": frequencey,
                "critiquerExpected": critiquerExpected
        ]
    }

    init(id: String, displayName: String, bio: String,  photoURL: String, writing: String, authors: [String], writingGenres: [String], colour: Int, rating: Int, critiqueStyle: String, blockedUserIds: [String], lastCritique: Timestamp?, lastFiveCritiques: [Timestamp]?, frequencey: Double?, critiquerExpected: String?) {
        self.id = id
        self.displayName = displayName
        self.bio = bio
        self.photoURL = photoURL
        self.writing = writing
        self.authors = authors
        self.writingGenres = writingGenres
		self.colour = colour
		self.rating = rating
		self.critiqueStyle = critiqueStyle
        self.blockedUserIds = blockedUserIds
        self.lastCritique = lastCritique
        self.lastFiveCritiques = lastFiveCritiques
        self.frequencey = frequencey
        self.critiquerExpected = critiquerExpected
    }
}

extension User {
    convenience init?(dictionary: [String: Any], id: String) {

		guard let bio = dictionary["bio"] as? String,
			  let displayName = dictionary["displayName"] as? String,
			  let photoURL = dictionary["photoURL"] as? String,
			  let writing = dictionary["writing"] as? String,
			  let critiqueStyle = dictionary["critiqueStyle"] as? String,
			  let authors = dictionary["authors"] as? [String],
			  let writingGenres = dictionary["writingGenres"] as? [String],
			  let colour = dictionary["colour"] as? Int,
			  let rating = dictionary["rating"] as? Int
		else { return nil }
        
        let lastCritique = dictionary["lastCritique"] as? Timestamp? ?? nil
        let lastFiveCritiques = dictionary["lastFiveCritiques"] as? [Timestamp]? ?? nil
        let frequencey = dictionary["frequencey"] as? Double? ?? nil
        let critiquerExpected = dictionary["critiquerExpected"] as? String? ?? nil

        self.init(id: id, displayName: displayName, bio: bio,  photoURL: photoURL, writing: writing, authors: authors, writingGenres: writingGenres, colour: colour, rating: rating, critiqueStyle: critiqueStyle, blockedUserIds: dictionary["blockedUserIds"] as? [String] ?? [],
                  lastCritique: lastCritique,
                  lastFiveCritiques: lastFiveCritiques,
                  frequencey: frequencey,
                  critiquerExpected: critiquerExpected
        )
    }
}
