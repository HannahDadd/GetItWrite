//
//  ViewAllPromo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 31/01/2025.
//

import SwiftUI

struct ViewAllPromo: View {
    @State var showPopUp = false
    
    var body: some View {
        .sheet(isPresented: self.$showPopUp) {
            CreateBulletinView(showPopUp: self.$showPopUp)
        }
    }
}
