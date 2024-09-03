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
                TitleAndSubtitle(title: "Recommended critique partners", subtitle: "Specially picked out for you.")
                HStack(alignment: .center) {
                    ForEach(users) {
                        RecCard(name: $0.displayName, size: 120)
                    }
                }.padding(.horizontal)
            }
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
    let name: String
    let size: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: "person.fill")
            Text(name)
                .foregroundColor(Color.onCardBackground)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding()
        .frame(width: size, height: size)
        .background(Color.cardBackground)
        .cornerRadius(8)
    }
}
