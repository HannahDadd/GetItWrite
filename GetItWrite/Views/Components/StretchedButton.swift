//
//  StretchedButton.swift
//  Get It Write
//
//  Created by Hannah Dadd on 15/08/2025.
//

import SwiftUI

struct StretchedButton: View {
    var text: String
    var action: () -> Void
    
    var body : some View {
        Button(action: {
            self.action()
        }) {
            Text(text)
                .font(.headline)
                .foregroundColor(Color.white)
                .padding(EdgeInsets(top: 12, leading: 39, bottom: 12, trailing: 39))
                .background(Color.black)
                .clipShape(Capsule(style: .circular))
        }
        .accentColor(Color.clear)
    }
}
