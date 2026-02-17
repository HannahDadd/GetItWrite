//
//  WritingGamesPromo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 17/02/2026.
//

import SwiftUI

struct WritingGamesPromo: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Image("WritingGamesPromo")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("Download Writing Games")
                .font(Font.custom("AbrilFatface-Regular", size: 34))
                .multilineTextAlignment(.leading)
            Text("Download Writing Games to show off your writing skills")
                .font(Font.custom("Bellefair-Regular", size: 18))
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding()
    }
}
