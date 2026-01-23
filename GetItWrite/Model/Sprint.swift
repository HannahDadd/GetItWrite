//
//  Sprint.swift
//  Get It Write
//
//  Created by Hannah Dadd on 13/01/2026.
//

import Firebase

//struct Sprint: Hashable {
//    let id: String
//    let participants: [String]
//    let timestamp: Timestamp
//    let writerId: String
//    let writerName: String
//    
//    var dictionary: [String: Any?] {
//        return ["text": text,
//                "timestamp": timestamp,
//                "writerId": writerId,
//                "writerName": writerName
//        ]
//    }
//    
//    internal init(id: String, timestamp: Timestamp, writerName: String, writerId: String, text: String) {
//        self.id = id
//        self.timestamp = timestamp
//        self.writerName = writerName
//        self.writerId = writerId
//        self.text = text
//    }
//    
//    convenience init?(dictionary: [String: Any], id: String) {
//        
//        guard let writerId = dictionary["writerId"] as? String,
//              let text = dictionary["text"] as? String,
//              let writerName = dictionary["writerName"] as? String,
//              let timestamp = dictionary["timestamp"] as? Timestamp
//        else { return nil }
//        
//        self.init(id: id, timestamp: timestamp, writerName: writerName, writerId: writerId, text: text)
//    }
//    
//    static func == (lhs: Sprint, rhs: Sprint) -> Bool {
//        return lhs.id == rhs.id
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//    
//    func formatDate() -> String {
//        let formatter = RelativeDateTimeFormatter()
//        formatter.unitsStyle = .short
//        return formatter.localizedString(for: timestamp.dateValue(), relativeTo: Date())
//    }
//}
