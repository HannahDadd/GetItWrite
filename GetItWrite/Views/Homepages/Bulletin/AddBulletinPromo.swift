//
//  AddBulletin.swift
//  Get It Write
//
//  Created by Hannah Dadd on 28/01/2025.
//

import SwiftUI

struct AddBulletinPromo: View {
    @State var showPopUp = false
    
    var body: some View {
        PopupPromo(title: "Has your query letter seen success?", subtitle: "Consider sharing it here to inspire other writers!", action: {
            showPopUp = true
        })
        .sheet(isPresented: self.$showPopUp) {
            CreateBulletinView(showPopUp: self.$showPopUp)
        }
    }
}
