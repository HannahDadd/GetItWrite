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
            VStack {
                TitleAndSubtitle(title: "Recommended critique partners", subtitle: "Specially picked out for you.")
                HStack {
                    ForEach(users) {
                        Text($0.displayName)
                    }
                }
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
