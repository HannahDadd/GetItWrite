//
//  Reply.swift
//  Get It Write
//
//  Created by Hannah Billingsley-Dadd on 12/04/2024.
//

import Firebase

struct Reply: Identifiable, Hashable {

    let id = UUID()
    var reply: String
    var replierId: String
    var replierName: String
    var replierColour: Int
    var timestamp: Timestamp
    
    var dictionary: [String: Any] {
        return ["reply": reply,
                "replierId": replierId,
                "replierName": replierName,
                "replierColour": replierColour,
                "timestamp": timestamp
        ]
    }
}

extension Reply {
    init?(dictionary: [String: Any]) {
        
        guard let reply = dictionary["reply"] as? String,
              let replierId = dictionary["replierId"] as? String,
              let replierName = dictionary["replierName"] as? String,
              let replierColour = dictionary["replierColour"] as? Int,
              let timestamp = dictionary["timestamp"] as? Timestamp
        else { return nil }
        
        self.init(reply: reply, replierId: replierId, replierName: replierName, replierColour: replierColour, timestamp: timestamp)
    }
    
    func formatDate() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: timestamp.dateValue(), relativeTo: Date())
    }
}
