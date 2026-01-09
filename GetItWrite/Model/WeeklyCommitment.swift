//
//  WeeklyCommitment.swift
//  Get It Write
//
//  Created by Hannah Dadd on 08/08/2025.
//

import Foundation

struct WeeklyCommitment: Encodable, Decodable {
    var writingDays: [String]
    var time: Date
}
