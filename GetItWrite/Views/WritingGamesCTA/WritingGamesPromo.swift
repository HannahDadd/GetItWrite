//
//  WritingGamesPromo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 17/02/2026.
//

import SwiftUI

struct WritingGamesPromo: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Download Writing Games")
                .font(Font.custom("AbrilFatface-Regular", size: 24))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            Image("WritingGamesPromo")
                .resizable()
                .frame(maxWidth: .infinity)
            Text("Download Writing Games to show off your writing skills")
                .font(Font.custom("Bellefair-Regular", size: 18))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            Spacer()
        }
        .padding()
    }
}
