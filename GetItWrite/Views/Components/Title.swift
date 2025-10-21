//
//  Title.swift
//  Get It Write
//
//  Created by Hannah Dadd on 20/10/2025.
//

import SwiftUI

struct TitleAndSubtitle: View {
    var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .multilineTextAlignment(.leading)
                .textCase(.uppercase)
        }
        .padding(.horizontal)
        .padding(.top)
    }
}
