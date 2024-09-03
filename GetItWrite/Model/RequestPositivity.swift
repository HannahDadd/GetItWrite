//
//  RequestPositivity.swift
//  Get It Write
//
//  Created by Hannah Dadd on 02/09/2024.
//

import Foundation

final class RequestPositivity: UserGeneratedContent {
    var id: String
    var text: String
    var writerId: String
    var writerName: String
    var comments: [String: String]
    
    var dictionary: [String: Any?] {
        return ["text": text,
                "writerId": writerId,
                "writerName": writerName,
                "comments": comments
        ]
    }
    
    init(id: String, text: String, writerId: String, writerName: String, comments: [String : String]) {
        self.id = id
        self.text = text
        self.writerId = writerId
        self.writerName = writerName
        self.comments = comments
    }
}

extension RequestPositivity {
    convenience init?(dictionary: [String: Any], id: String) {

        guard let text = dictionary["text"] as? String,
              let writerId = dictionary["writerId"] as? String,
              let photoURL = dictionary["photoURL"] as? String,
              let writerName = dictionary["writerName"] as? String,
              let comments = dictionary["comments"] as? [String: String]
        else { return nil }

        self.init(id: id, text: text, writerId: writerId, writerName: writerName, comments: comments)
    }
}


