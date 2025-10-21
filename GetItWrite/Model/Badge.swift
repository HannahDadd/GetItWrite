//
//  Badge.swift
//  Get It Write
//
//  Created by Hannah Dadd on 21/10/2025.
//

import Foundation

struct Badge: Encodable, Decodable, Identifiable {
    let id: Int
    let score: Int
    let title: String
}
