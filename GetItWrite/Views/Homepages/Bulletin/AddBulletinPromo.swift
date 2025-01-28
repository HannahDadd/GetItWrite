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
        PopupPromo(title: "Looking for critique parters?", subtitle: "Post some info about your project on the noticeboard!", action: {
            showPopUp = true
        })
        .sheet(isPresented: self.$showPopUp) {
            CreateBulletinView(showPopUp: self.$showPopUp)
        }
    }
}
