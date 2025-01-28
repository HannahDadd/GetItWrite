//
//  BulletinSection.swift
//  Get It Write
//
//  Created by Hannah Dadd on 28/01/2025.
//

import SwiftUI

struct BulletinSection: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var result: Result<[SuccessfulQuery], Error>?
    
    var body: some View {
        switch result {
        case .success(let requests):
            VStack(alignment: .leading) {
                TitleAndSubtitle(
                    title: "Successful Queries",
                    subtitle: "Queries that got a full request or even led to an agent.")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Array(requests.prefix(5)), id: \.id) { s in
                            NavigationLink(
                                destination:
                                    SuccessfulQueryView(successfulQuery: s)
                                    .environmentObject(session)) {
                                        CarouselCard(
                                            icon: "envelope.fill",
                                            title: s.text,
                                            bubbleText:  "\(s.text.components(separatedBy: .whitespacesAndNewlines).count) words"
                                        )
                                    }
                        }
                        
                        NavigationLink(destination: SuccessfulQueriesFeed(requests: requests)) {
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
