//
//  Title.swift
//  Get It Write
//
//  Created by Hannah Dadd on 20/10/2025.
//

import SwiftUI

struct HeadlineAndSubtitle: View {
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(Font.custom("AbrilFatface-Regular", size: 34))
            Text(subtitle)
                .multilineTextAlignment(.leading)
                .font(.headline)
            VStack {
                EmptyView()
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.bottom, 16)
    }
}

struct Title: View {
    var title: String
    
    var body: some View {
        Text(title)
            .multilineTextAlignment(.leading)
            .textCase(.uppercase)
    }
}

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
