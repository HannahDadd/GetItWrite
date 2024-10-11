//
//  ToCritiqueSection.swift
//  Get It Write
//
//  Created by Hannah Dadd on 11/10/2024.
//

import SwiftUI
import FirebaseFirestore

struct ToCritiqueSection: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var result: Result<[RequestCritique], Error>?
    @State var showPopUp = false
    
    let isQueries: Bool
    
    var body: some View {
        switch result {
        case .success(let critiques):
            if critiques.isEmpty {
                EmptyView()
            } else {
                TitleAndSubtitle(
                    title: "Work to Critique:",
                    subtitle: "Work sent by your critique partners, awaiting your review.")
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(critiques, id: \.id) { c in
                            NavigationLink(
                                destination:
                                    GiveCritiqueView(requestCritique: c)
                                    .environmentObject(session)) {
                                        CarouselCard(
                                            icon: "pencil.circle.fill",
                                            title: c.title,
                                            bubbleText: "\(c.text.components(separatedBy: .whitespacesAndNewlines).count) words"
                                        )
                                    }
                        }
                    }.padding()
                }
            }
        case .failure(let error):
            ErrorView(error: error, retryHandler: loadRequests)
        case nil:
            ProgressView().onAppear(perform: loadRequests)
        }
    }
    
    private func loadRequests() {
        session.loadRequestCritiques {
            result = $0
        }
    }
}
