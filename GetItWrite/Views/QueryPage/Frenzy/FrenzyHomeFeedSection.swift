//
//  FrenzyHomeFeedSection.swift
//  Get It Write
//
//  Created by Hannah Dadd on 02/09/2024.
//

import SwiftUI

struct FrenzyHomeFeedSection: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var result: Result<[RequestCritique], Error>?
    
    let isQueries: Bool
    
    var body: some View {
        switch result {
        case .success(let requests):
            VStack(alignment: .leading) {
                TitleAndSubtitle(
                    title: isQueries ? "Quick Query Critique" : "Critique Frenzy",
                    subtitle: "No partners, no swaps, just feedback.")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Array(requests.prefix(5)), id: \.id) { r in
                            NavigationLink(
                                destination:
                                    GiveCritiqueView(requestCritique: r)
                                    .environmentObject(session)) {
                                        QueryCard(requestCritique: r)
                                    }
                        }
                        
                        NavigationLink(destination: CritiqueFrenzyView(requests: requests, isQueries: isQueries)) {
                            CarouselCard(
                                icon: "arrow.forward",
                                title: "View More",
                                bubbleText: nil)
                        }
                    }
                    .padding(.horizontal)
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
            }
        case .failure(let error):
            ErrorView(error: error, retryHandler: loadRequests)
        case nil:
            ProgressView().onAppear(perform: loadRequests)
        }
    }
    
    private func loadRequests() {
        session.loadCritiqueFrenzy(dbName: isQueries ? DatabaseNames.queryFrenzy.rawValue : DatabaseNames.critiqueFrenzy.rawValue) {
            result = $0
        }
    }
}
