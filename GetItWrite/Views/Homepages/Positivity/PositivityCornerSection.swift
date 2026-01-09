//
//  PositivityCorner.swift
//  Get It Write
//
//  Created by Hannah Dadd on 02/09/2024.
//

import SwiftUI

struct PositivityCornerSection: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            TitleAndSubtitle(
                title: "Just Positive Vibes",
                subtitle: "Could any of these authors be your next critique partner?")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    CritiquePositivityCard()
                    MakePositivityCard()
                }
                .scrollTargetLayout()
                .padding(.horizontal)
            }
        }
        .scrollTargetBehavior(.viewAligned)
    }
}
