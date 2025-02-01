//
//  FrenziesCritiqued.swift
//  Get It Write
//
//  Created by Hannah Dadd on 02/09/2024.
//

import SwiftUI

struct FrenziesCritiqued: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var result: Result<[Critique], Error>?
    @State var showPopUp = false
    
    let isQueries: Bool
    
    var body: some View {
        switch result {
        case .success(let critiques):
            VStack {
                TitleAndSubtitle(
                    title: isQueries ? "Quick Query Critique" : "Critique Frenzy",
                    subtitle: isQueries ? "Critiques and your queries." : "No partners, no swaps, just feedback on your work.")
                if !critiques.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(Array(critiques.prefix(5)), id: \.id) { c in
                                NavigationLink(
                                    destination:
                                        ViewCritiqueView(critique: c)
                                        .environmentObject(session)) {
                                            CarouselCard(
                                                icon: isQueries ? "envelope.fill" : "highlighter",
                                                title: c.projectTitle,
                                                bubbleText: "\(c.comments.count) comments"
                                            )
                                        }
                            }
                            if critiques.count > 5 {
                                NavigationLink(
                                    destination:
                                        CritiquesView(critiques: critiques)) {
                                            CarouselCard(
                                                icon: "arrow.forward",
                                                title: "View More",
                                                bubbleText: nil)
                                        }
                            }
                        }
                        .padding()
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
        session.loadCritiquedFrenzy(dbName: isQueries ? DatabaseNames.queryFrenzy.rawValue : DatabaseNames.critiqueFrenzy.rawValue) {
            result = $0
        }
    }
}
