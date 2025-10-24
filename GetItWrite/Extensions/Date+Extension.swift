//
//  Date+Extension.swift
//  Get It Write
//
//  Created by Hannah Dadd on 24/10/2025.
//

import Foundation

extension Date: RawRepresentable {
    public var rawValue: String {
        ISO8601DateFormatter().string(from: self)
    }
    
    public init?(rawValue: String) {
        guard let date = ISO8601DateFormatter().date(from: rawValue) else {
            return nil
        }
        self = date
    }
}

extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return abs(lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate)
    }

}
