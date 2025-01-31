//
//  MakePositivityCard.swift
//  Get It Write
//
//  Created by Hannah Dadd on 31/01/2025.
//

import SwiftUI

struct MakePositivityCard: View {
    @EnvironmentObject var session: FirebaseSession
    @State var showPopUp = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Need some Positive vibes?")
                .bold()
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
            Text("Post your work here to get positive feedback.")
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .lineLimit(5)
        }
        .padding()
        .frame(width: 280, height: 140)
        .background(Color.makePosCard)
        .cornerRadius(8)
        .sheet(isPresented: self.$showPopUp) {
            MakePositivity(showMakeCritiqueView: self.$showPopUp)
        }
    }
}
