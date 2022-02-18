//
//  User.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/02/2022.
//

import Foundation

class User: Identifiable {

    var id: String
    var username: String
    var displayName: String?
    var bio: String?
    var photoURL: URL?

    var dictionary: [String: Any?] {
        return ["username": username,
                "displayName": displayName,
                "bio": bio,
                "photoURL": photoURL
        ]
    }

    init(id: String, username: String, displayName: String?, bio: String?,  photoURL: URL? = nil) {
        self.id = id
        self.username = username
        self.displayName = displayName
        self.bio = bio
        self.photoURL = photoURL
    }

    func updateUser(photoURL: URL?, displayName: String?, bio: String?) {
        if (photoURL != nil) { self.photoURL = photoURL }
        if (displayName != nil) { self.displayName = displayName }
        if (bio != nil) { self.bio = bio }
    }
}

extension User {
    convenience init?(dictionary: [String: Any], id: String) {

        let bio = dictionary["bio"] as? String
        let displayName = dictionary["displayName"] as? String
        let photoUrl = dictionary["photoURL"] as? String
        let username = dictionary["username"] as! String

        self.init(id: id, username: username, displayName: displayName, bio: bio, photoURL: URL(string: photoUrl ?? ""))
    }
}

