//
//  BubbleButton.swift
//  Get It Write
//
//  Created by Hannah Dadd on 31/01/2025.
//

import SwiftUI

struct BubbleButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(4)
            .background(Color.primary)
            .foregroundStyle(Color.onPrimary)
            .cornerRadius(3)
            //.clipShape(Rectangle())
    }
}
