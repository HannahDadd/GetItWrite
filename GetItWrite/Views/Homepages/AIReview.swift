//
//  AIReview.swift
//  Get It Write
//
//  Created by Hannah Dadd on 02/09/2024.
//

import SwiftUI

struct AIPromo: View {
    @State var showPopUp = false

    var body: some View {
        VStack {
            ImagePromo(image: "aibg", text: "Get instant AI feedback on your writing.", bubbleText: "Give it a go") {
                showPopUp = true
            }
        }
        .sheet(isPresented: self.$showPopUp) {
            AIReview()
        }
    }
}

struct AIReview: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
