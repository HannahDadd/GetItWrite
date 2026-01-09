//
//  BulletinFeed.swift
//  Get It Write
//
//  Created by Hannah Dadd on 28/01/2025.
//

import SwiftUI

struct BulletinFeed: View {
    @EnvironmentObject var session: FirebaseSession
    @State var showPopUp = false
    
    let requests: [SuccessfulQuery]
    
    var body: some View {
        ZStack {
            ScrollView {
                ForEach(requests, id: \.id) { i in
                    SuccessfulQueryListView(successfulQuery: i)
                }.padding()
            }
        }
        .navigationTitle("Noticeboard")
        .overlay(alignment: .bottomTrailing) {
            Button(action: { self.showPopUp.toggle() }) {
                Image(systemName: "plus.app.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.lightBackground)
            }.padding()
        }
        .sheet(isPresented: self.$showPopUp) {
            CreateBulletinView(showPopUp: self.$showPopUp)
        }
    }
}
