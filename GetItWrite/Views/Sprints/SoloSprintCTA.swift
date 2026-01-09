//
//  SprintCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 15/08/2025.
//

import SwiftUI

struct SoloSprintCTA: View {
    var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Start a Solo Sprint")
                .font(Font.custom("AbrilFatface-Regular", size: 24))
                .foregroundColor(Color.white)
                .multilineTextAlignment(.leading)
            Spacer()
            Text("Sprint on your own to get those words written")
                .foregroundColor(Color.white)
                .bold()
                .multilineTextAlignment(.leading)
        }
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .background(Color.brightGreen)
        .cornerRadius(8)
        .onTapGesture {
            action()
        }
        .padding()
    }
}
