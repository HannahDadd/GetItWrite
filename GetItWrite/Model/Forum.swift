//
//  Forum.swift
//  Get It Write
//
//  Created by Hannah Billingsley-Dadd on 12/04/2024.
//

import Firebase

struct Question: Identifiable, Hashable {

    let id = UUID()
    var question: String
    var questionnerId: String
    var questionnerName: String
    var questionnerColour: String
    var timestamp: Timestamp

    var dictionary: [String: Any] {
        return ["users": users]
    }
}

extension Question {
    init?(dictionary: [String: Any]) {
        guard let chatUsers = dictionary["users"] as? [String] else { return nil }
        self.init(users: chatUsers)
    }
    
    func formatDate() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: timestamp.dateValue(), relativeTo: Date())
    }
}
