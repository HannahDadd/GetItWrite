//
//  CritiqueFrenzyFeed.swift
//  Get It Write
//
//  Created by Hannah Billingsley-Dadd on 16/04/2024.
//

import SwiftUI

struct CritiqueFrenzyView: View {
    @EnvironmentObject var session: FirebaseSession
    @State var showMakeCritiqueView = false
    
    let requests: [RequestCritique]
    
    var body: some View {
        ZStack {
            List {
                ForEach(requests, id: \.id) { i in
                    RequestCritiqueView(requestCritique: i)
                }
            }.listStyle(.plain)
        }
        .overlay(alignment: .bottomTrailing) {
            Button(action: { self.showMakeCritiqueView.toggle() }) {
                Image(systemName: "plus.app.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.lightBackground)
            }.padding()
        }
        .sheet(isPresented: self.$showMakeCritiqueView) {
            CreateCritiqueFrenzy(showMakeCritiqueView: self.$showMakeCritiqueView).environmentObject(self.session)
        }
    }
}
