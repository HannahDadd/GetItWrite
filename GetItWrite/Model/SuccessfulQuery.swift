//
//  SuccessfulQuery.swift
//  Get It Write
//
//  Created by Hannah Dadd on 27/01/2025.
//

import Firebase
import SwiftUI

class SuccessfulQuery: Hashable, UserGeneratedContent {

    let id: String
    let text: String
    let timestamp: Timestamp
    let writerId: String
    let writerName: String

    var dictionary: [String: Any?] {
        return ["text": text,
                "timestamp": timestamp,
                "writerId": writerId,
                "writerName": writerName
        ]
    }

    internal init(id: String, timestamp: Timestamp, writerName: String, writerId: String, text: String) {
        self.id = id
        self.timestamp = timestamp
        self.writerName = writerName
        self.writerId = writerId
        self.text = text
    }
}

extension SuccessfulQuery {
    convenience init?(dictionary: [String: Any], id: String) {

        guard let writerId = dictionary["writerId"] as? String,
              let text = dictionary["text"] as? String,
              let writerName = dictionary["writerName"] as? String,
              let timestamp = dictionary["timestamp"] as? Timestamp
        else { return nil }

        self.init(id: id, timestamp: timestamp, writerName: writerName, writerId: writerId, text: text)
    }

    static func == (lhs: SuccessfulQuery, rhs: SuccessfulQuery) -> Bool {
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
