//
//  SuccessfulQueryPromo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 28/01/2025.
//

import SwiftUI

struct SuccessfulQueryPromo: View {
    @State var showPopUp = false
    
    var body: some View {
        PopupPromo(title: "Had a full request?", subtitle: "Share your query here to inspire others!", action: {
            showPopUp = true
        })
        .sheet(isPresented: self.$showPopUp) {
            CreateSuccessfulQuery(showPopUp: self.$showPopUp)
        }
    }
}
