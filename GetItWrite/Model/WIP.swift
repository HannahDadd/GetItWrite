//
//  Goal.swift
//  Get It Write
//
//  Created by Hannah Dadd on 05/09/2024.
//

import Foundation

struct WeeklyCommitment: Encodable, Decodable {
    var writingDays: [String]
    var time: Date
}
