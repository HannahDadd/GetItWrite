//
//  AddBookPromo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 31/01/2025.
//

import SwiftUI

struct AddBookPromo: View {
    @State var showPopUp = false
    
    var body: some View {
        PicturePromo(text: "Ready for feedback?", buttonText: "Share Your Book", picture: "addBookPromo") {
            showPopUp = true
        }
        .sheet(isPresented: self.$showPopUp) {
            MakeProposalsView(showMakeProposalView: self.$showPopUp)
        }
    }
}
