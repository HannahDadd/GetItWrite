//
//  SprintPromo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 13/02/2026.
//

import SwiftUI

struct SprintPromo: View {
    var action: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 18) {
            Text("Get some Writing Focus Time")
                .font(Font.custom("Bellefair-Regular", size: 24))
                .foregroundColor(.white)
            HStack {
                VStack {
                    Spacer()
                    Text("Tap here to start a sprint")
                        .font(Font.custom("Bellefair-Regular", size: 22))
                        .foregroundColor(.white)
                }
                Spacer()
                Image(systemName: "books.vertical.fill")
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { size, axis in
                        size * 0.4
                    }
                    .foregroundStyle(.white)
            }
            VStack {
                EmptyView()
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.CardPurple)
        .cornerRadius(8)
        .onTapGesture {
            action()
        }
        .shadow(radius: 5)
        .padding()
    }
}
