//
//  Date+Extension.swift
//  Get It Write
//
//  Created by Hannah Dadd on 24/10/2025.
//

import Foundation

extension Date: @retroactive RawRepresentable {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    public var rawValue: String {
        Date.dateFormatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.dateFormatter.date(from: rawValue) ?? Date()
    }
}
