//
//  SavedWritingCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 23/01/2026.
//

import SwiftUI

struct SavedWritingCTA: View {
    @State private var showingPopover = false
    
    var body: some View {
        NavigationLink {
            SavedWriting()
        } label: {
            HStack {
                Text("Your Saves")
                    .font(Font.custom("AbrilFatface-Regular", size: 24))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                Spacer()
                Image(systemName: "arrow.right")
                    .foregroundColor(Color.white)
            }
            .padding()
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .background(Color.GetItWriteCTA)
            .cornerRadius(8)
            .padding(.top, 24)
        }
    }
}
