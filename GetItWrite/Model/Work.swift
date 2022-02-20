//
//  Work.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 20/02/2022.
//

import Firebase

class Work: Hashable {

    let id: String
    let text: String
    let blurb: String
    let genres: [String]
    let timestamp: Timestamp
    let posterImage: String
    let posterId: String
    let posterUsername: String

    var dictionary: [String: Any] {
        return [
            "text": text,
            "genres": genres,
            "blurb": blurb,
            "timestamp": timestamp,
            "posterImage": posterImage,
            "posterId": posterId,
            "posterUsername": posterUsername
        ]
    }

    internal init(id: String, text: String, blurb: String, genres: [String], timestamp: Timestamp, posterImage: String, posterId: String, posterUsername: String) {
        self.id = id
        self.text = text
        self.genres = genres
        self.blurb = blurb
        self.timestamp = timestamp
        self.posterImage = posterImage
        self.posterId = posterId
        self.posterUsername = posterUsername
    }
}

extension Work {
    convenience init?(dictionary: [String: Any], id: String) {

        guard let text = dictionary["text"] as? String,
            let genres = dictionary["genres"] as? [String],
            let blurb = dictionary["blurb"] as? String,
            let posterId = dictionary["posterId"] as? String,
            let posterImage = dictionary["posterImage"] as? String,
            let posterUsername = dictionary["posterUsername"] as? String,
            let timestamp = dictionary["timestamp"] as? Timestamp
            else { return nil }

        self.init(id: id, text: text, blurb: blurb, genres: genres, timestamp: timestamp, posterImage: posterImage, posterId: posterId, posterUsername: posterUsername)
    }

    static func == (lhs: Work, rhs: Work) -> Bool {
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
