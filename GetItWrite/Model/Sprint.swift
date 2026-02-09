//
//  Sprint.swift
//  Get It Write
//
//  Created by Hannah Dadd on 13/01/2026.
//

import Firebase

final class Sprint: Hashable {
    let id: String
    let participants: [String]
    let timestamp: Timestamp
    
    var dictionary: [String: Any?] {
        return ["participants": participants,
                "timestamp": timestamp
        ]
    }
    
    internal init(id: String, timestamp: Timestamp, participants: [String]) {
        self.id = id
        self.timestamp = timestamp
        self.participants = participants
    }
    
    convenience init?(dictionary: [String: Any], id: String) {
        
        guard let participants = dictionary["participants"] as? [String],
              let timestamp = dictionary["timestamp"] as? Timestamp
        else { return nil }
        
        self.init(id: id, timestamp: timestamp, participants: participants)
    }
    
    static func == (lhs: Sprint, rhs: Sprint) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
