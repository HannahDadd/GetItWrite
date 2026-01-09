//
//  QueryCard.swift
//  Get It Write
//
//  Created by Hannah Dadd on 31/01/2025.
//

import SwiftUI

struct QueryCard: View {
    let requestCritique: RequestCritique
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(requestCritique.genres.joined(separator: ", "))
                .font(Font.custom("AbrilFatface-Regular", size: 32))
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            Spacer()
            HStack {
                Spacer()
                TransparentBoxView(text: "\(requestCritique.text.components(separatedBy: .whitespacesAndNewlines).count) words")
            }
        }
        .padding()
        .frame(width: 230, height: 230)
        .background(Color.questionbg)
        .cornerRadius(8)
    }
}
