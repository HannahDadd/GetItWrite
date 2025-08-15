//
//  Recs.swift
//  Get It Write
//
//  Created by Hannah Dadd on 02/09/2024.
//

import SwiftUI

struct Recs: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var result: Result<[User], Error>?
    
    var body: some View {
        switch result {
        case .success(let users):
            VStack(alignment: .leading) {
                Text("Recomended Critique Partners")
                    .multilineTextAlignment(.leading)
                    .textCase(.uppercase)
                    .padding(.horizontal)
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                    ForEach(users) { u in
                        RecCard(user: u, size: 100)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        case .failure(let error):
            ErrorView(error: error, retryHandler: loadRequests)
        case nil:
            ProgressView().onAppear(perform: loadRequests)
        }
    }
    
    private func loadRequests() {
        session.getRecs() {
            result = $0
        }
    }
}

struct RecCard: View {
    @State private var writerPopup = false
    let user: User
    let size: CGFloat
    
    var body: some View {
        Button(action: { writerPopup = true }) {
            VStack {
                Text(user.displayName)
                    .font(.subheadline)
                    .foregroundColor(Color.onSecondary)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .background(Color.secondary)
            .cornerRadius(8)
        }
        .sheet(isPresented: self.$writerPopup) {
            ProfileView(id: user.id)
        }
    }
}
