//
//  PicturePromo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 31/01/2025.
//

import SwiftUI

struct PicturePromo: View {
    var text: String
    var buttonText: String
    var picture: String
    var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(picture)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(4)
            Text(text)
                .multilineTextAlignment(.leading)
                .font(.headline)
            HStack {
                Spacer()
                Button(buttonText) {
                    action()
                }
                .buttonStyle(BubbleButton())
            }
        }
        .padding()
    }
}

struct BubbleButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(Color.primary)
            .foregroundStyle(Color.onPrimary)
            .cornerRadius(8)
            //.clipShape(Rectangle())
    }
}
