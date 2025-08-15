//
//  Forum.swift
//  Get It Write
//
//  Created by Hannah Billingsley-Dadd on 12/04/2024.
//

import Firebase

struct Question: Identifiable, Hashable, UserGeneratedContent {
    let id: String
    let question: String
    let questionerId: String
    let questionerName: String
    let questionerColour: Int
    let timestamp: Timestamp

    var dictionary: [String: Any?] {
        return ["question": question,
                "questionerId": questionerId,
                "questionerName": questionerName,
                "questionerColour": questionerColour,
                "timestamp": timestamp
        ]
    }
}

extension Question {
    init?(dictionary: [String: Any], id: String) {
        
        guard let question = dictionary["question"] as? String,
              let questionerId = dictionary["questionerId"] as? String,
              let questionerName = dictionary["questionerName"] as? String,
              let questionerColour = dictionary["questionerColour"] as? Int,
              let timestamp = dictionary["timestamp"] as? Timestamp
        else { return nil }
        
        self.init(id: id, question: question, questionerId: questionerId, questionerName: questionerName, questionerColour: questionerColour, timestamp: timestamp)
    }
    
    func formatDate() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: timestamp.dateValue(), relativeTo: Date())
    }
}
