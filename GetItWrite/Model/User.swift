//
//  User.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/02/2022.
//

import Foundation

class User: Identifiable {

    var id: String
    var displayName: String?
    var bio: String?
    var photoURL: URL?
    var writing: String?
    var authors: [String]
    var writingGenres: [String]

    var dictionary: [String: Any?] {
        return ["displayName": displayName,
                "bio": bio,
                "photoURL": photoURL,
                "writing": writing,
                "authors": authors,
                "writingGenres": writingGenres
        ]
    }

    init(id: String, displayName: String?, bio: String?,  photoURL: URL?, writing: String?, authors: [String], writingGenres: [String]) {
        self.id = id
        self.displayName = displayName
        self.bio = bio
        self.photoURL = photoURL
        self.writing = writing
        self.authors = authors
        self.writingGenres = writingGenres
    }
}

extension User {
    convenience init?(dictionary: [String: Any], id: String) {

        let bio = dictionary["bio"] as? String
        let displayName = dictionary["displayName"] as? String
        let photoUrl = dictionary["photoURL"] as? String
        let writing = dictionary["writing"] as? String
        let authors = dictionary["authors"] as? [String]
        let writingGenres = dictionary["writingGenres"] as? [String]

        if let photoUrl = photoUrl {
            self.init(id: id, displayName: displayName, bio: bio,  photoURL: URL(string: photoUrl), writing: writing, authors: authors ?? [], writingGenres: writingGenres ?? [])
        } else {
            self.init(id: id, displayName: displayName, bio: bio,  photoURL: nil, writing: writing, authors: authors ?? [], writingGenres: writingGenres ?? [])
        }
    }
}

