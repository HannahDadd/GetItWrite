//
//  WritingGamesCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 17/02/2026.
//

import SwiftUI

struct WritingGamesCTA: View {
    @State private var showingPopover = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Looing for some fun?")
                .font(Font.custom("AbrilFatface-Regular", size: 24))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            Spacer()
            Text("Download Writing Games to show off your writing skills")
                .font(Font.custom("Bellefair-Regular", size: 18))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            VStack {
                EmptyView()
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(height: 140)
        .frame(maxWidth: .infinity)
        .background(Color.editingGames)
        .cornerRadius(8)
        .padding()
        .onTapGesture {
            showingPopover = true
        }
        .popover(isPresented: $showingPopover) {
            WritingGamesPromo()
        }
    }
}
