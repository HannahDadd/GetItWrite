//
//  PopupPromo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 28/01/2025.
//

import SwiftUI

struct PopupPromo: View {
    var title: String
    var subtitle: String
    var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .multilineTextAlignment(.leading)
                .font(.headline)
                .foregroundColor(Color.onSecondary)
            Spacer()
            Text(subtitle)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .font(.subheadline)
                .foregroundColor(Color.onSecondary)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(Color.secondary)
        .cornerRadius(8)
        .onTapGesture { action() }
        .shadow(radius: 5)
        .padding()
    }
}
