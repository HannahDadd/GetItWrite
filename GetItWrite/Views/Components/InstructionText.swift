//
//  InstructionText.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 04/05/2023.
//

import SwiftUI

struct FindPartnersText: View {
    var body: some View {
        Text("Select 'Books Needing Critiques' on the side bar ") + Text(Image(systemName: "hand.point.left")) + Text("  to find new critique partners.")
    }
}

struct SendMessagesText: View {
    var body: some View {
        Text("Select 'Messages' on the side bar ") + Text(Image(systemName: "hand.point.left")) + Text("  to send work to existing critique partners.")
    }
}
