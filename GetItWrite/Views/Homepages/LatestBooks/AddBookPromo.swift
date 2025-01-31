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
        VStack(alignment: .leading, spacing: 2) {
            Image("addBookPromo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(4)
            Text("Ready for feedback?")
                .multilineTextAlignment(.leading)
                .textCase(.uppercase)
            HStack {
                Spacer()
                Button("Share Your Book") {
                    print("Button pressed!")
                }
                .buttonStyle(BubbleButton())
            }
        }
        .padding()
        .sheet(isPresented: self.$showPopUp) {
            //MakeWIP(showPopUp: self.$showPopUp)
        }
    }
}
