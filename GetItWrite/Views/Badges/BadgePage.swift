//
//  BadgePage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 21/10/2025.
//

import SwiftUI

struct BadgePage: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            HeadlineAndSubtitle(title: "Your Progress", subtitle: "Writing games to keep you on top form.")
            Text("Your goal:")
                .font(Font.custom("Bellefair-Regular", size: 24))
            ScrollView {
                VStack(spacing: 24) {
                    ForEach(0..<25) {_ in
                        Image(systemName: "pawprint.fill")
                            .font(.system(size: 45))
                    }
                }
            }
        }
        .padding()
    }
}
