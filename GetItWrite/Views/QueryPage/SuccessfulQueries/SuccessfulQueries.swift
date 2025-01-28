//
//  SuccessfulQueries.swift
//  Get It Write
//
//  Created by Hannah Dadd on 27/01/2025.
//

import SwiftUI

struct SuccessfulQueriesSection: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var result: Result<[SuccessfulQuery], Error>?
    
    let isQueries: Bool
    
    var body: some View {
        switch result {
        case .success(let requests):
            VStack(alignment: .leading) {
                TitleAndSubtitle(
                    title: "Successful Queries",
                    subtitle: "Queries that got a full request or even led to an agent.")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Array(requests.prefix(5)), id: \.id) { r in
                            NavigationLink(
                                destination:
                                    GiveCritiqueView(requestCritique: r)
                                    .environmentObject(session)) {
                                        CarouselCard(
                                            icon: isQueries ? "envelope.fill" : "highlighter",
                                            title: r.genres.joined(separator: ", "),
                                            bubbleText: isQueries ? "Query" : "\(r.text.components(separatedBy: .whitespacesAndNewlines).count) words"
                                        )
                                    }
                        }
                        
                        NavigationLink(destination: CritiqueFrenzyView(requests: requests, isQueries: isQueries)) {
                            CarouselCard(
                                icon: "arrow.forward",
                                title: "View More",
                                bubbleText: nil)
                        }
                    }.padding(.horizontal)
                }
            }
        case .failure(let error):
            ErrorView(error: error, retryHandler: loadRequests)
        case nil:
            ProgressView().onAppear(perform: loadRequests)
        }
    }
    
    private func loadRequests() {
        session.loadSuccessfulQueries {
            result = $0
        }
    }
}
