//
//  CritiqueFrenzyFeed.swift
//  Get It Write
//
//  Created by Hannah Billingsley-Dadd on 16/04/2024.
//

import SwiftUI

struct CritiqueFrenzyView: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var result: Result<[RequestCritique], Error>?
    @State var showMakeCritiqueView = false
    
    var body: some View {
        switch result {
        case .success(let requests):
            ZStack {
                List {
                    ForEach(requests, id: \.id) { i in
                        RequestCritiqueView(requestCritique: i)
                    }
                }
                .refreshable {
                    loadRequests()
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
        case .failure(let error):
            ErrorView(error: error, retryHandler: loadRequests)
        case nil:
            ProgressView().onAppear(perform: loadRequests)
        }
    }
    
    private func loadRequests() {
        session.loadCritiqueFrenzy() {
            result = $0
        }
    }
}
