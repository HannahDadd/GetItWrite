//
//  Goal.swift
//  Get It Write
//
//  Created by Hannah Dadd on 05/09/2024.
//

import Foundation

struct Goal {

    let id = UUID().uuidString
    var type: String

    var dictionary: [String: Any?] {
        return [
            "type": type
        ]
    }
}

extension Goal {
    init?(dictionary: [String: Any]) {

        guard let type = dictionary["type"] as? String
            else { return nil }

        self.init(type: type)
    }
}
