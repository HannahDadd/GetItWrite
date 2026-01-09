//
//  Stat.swift
//  Get It Write
//
//  Created by Hannah Dadd on 23/08/2025.
//

import Foundation

struct Stat: Encodable, Decodable, Identifiable {
    let id: Int
    let wordsWritten: Int
    let date: Date
    let wipId: Int?
    let minutes: Int?
}
