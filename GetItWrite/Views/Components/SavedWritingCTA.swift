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
        VStack(alignment: .leading) {
            Text("Your Saves")
                .font(Font.custom("AbrilFatface-Regular", size: 24))
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
        .background(Color.GetItWriteCTA)
        .cornerRadius(8)
        .padding(.top, 24)
        .onTapGesture {
            showingPopover = true
        }
        .popover(isPresented: $showingPopover) {
            Text("Your content here")
                .font(.headline)
                .padding()
        }
    }
}
