//
//  StretchedButton.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 20/02/2022.
//

import SwiftUI

struct StretchedButton : View {
    var text : String
    var action : () -> Void
    var size: CGFloat = 50

    var body : some View {
        Button(action: { self.action() }) {
            Text(text).bold()
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(Color.darkReadable)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 5))
        }.accentColor(Color.clear)
    }
}
