//
//  LatestBooks.swift
//  Get It Write
//
//  Created by Hannah Dadd on 28/01/2025.
//

import SwiftUI

struct LatestBooksSection: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var result: Result<[Proposal], Error>?
    
    var body: some View {
        switch result {
        case .success(let requests):
            VStack(alignment: .leading) {
                TitleAndSubtitle(
                    title: "Latest in Books",
                    subtitle: "Could any of these authors be your next critique partner?")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Array(requests.prefix(5)), id: \.id) { p in
                            NavigationLink(
                                destination:
                                    ExpandedProposalView(proposal: p)
                                    .environmentObject(session)) {
                                        BookCard(proposal: p)
                                    }
                        }
                        NavigationLink(destination: ProposalsFeed(genre: "All")) {
                            CarouselCard(
                                icon: "arrow.forward",
                                title: "View More",
                                bubbleText: nil)
                        }
                    }
                    .scrollTargetLayout()
                    .padding(.horizontal)
                }
                .scrollTargetBehavior(.viewAligned)
            }
        case .failure(let error):
            ErrorView(error: error, retryHandler: loadProposals)
        case nil:
            ProgressView().onAppear(perform: loadProposals)
        }
    }
    
    private func loadProposals() {
        session.loadProposals() {
            result = $0
        }
    }
}
