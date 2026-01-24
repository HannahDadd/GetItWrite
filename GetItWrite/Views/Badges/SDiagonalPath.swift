//
//  SPath.swift
//  Get It Write
//
//  Created by Hannah Dadd on 24/01/2026.
//

import SwiftUI

struct SDiagonalPath: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let start = CGPoint(x: 0, y: rect.height * 0.8)
        let end = CGPoint(x: rect.width, y: rect.height * 0.2)

//        let control1 = CGPoint(x: rect.width * 0.25, y: rect.height)
//        let control2 = CGPoint(x: rect.width * 0.75, y: 0)
        let control1 = CGPoint(x: rect.width * 0.15, y: rect.height * 1.2)
        let control2 = CGPoint(x: rect.width * 0.85, y: -rect.height * 0.2)

        path.move(to: start)
        path.addCurve(
            to: end,
            control1: control1,
            control2: control2
        )

        return path
    }
}
