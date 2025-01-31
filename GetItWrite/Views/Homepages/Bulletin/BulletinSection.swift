//
//  BulletinSection.swift
//  Get It Write
//
//  Created by Hannah Dadd on 28/01/2025.
//

import SwiftUI

struct BulletinSection: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var result: Result<[Bulletin], Error>?
    
    var body: some View {
        switch result {
        case .success(let requests):
            VStack(alignment: .leading) {
                TitleAndSubtitle(
                    title: "Noticeboard",
                    subtitle: "Writers looking for critique partners.")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Array(requests.prefix(5)), id: \.id) { b in
                            NavigationLink(
                                destination:
                                    ExpandedBulletinView(b: b)
                                    .environmentObject(session)) {
                                        BulletinCard(bulletin: b, isFeed: false)
                                    }
                        }
                        
                        NavigationLink(destination: BulletinFeed(requests: requests)) {
                            CarouselCard(
                                icon: "arrow.forward",
                                title: "View More",
                                bubbleText: nil,
                                cardType: .noticeboard)
                        }
                    }
                    .scrollTargetLayout()
                    .padding(.horizontal)
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
        session.loadNoticeboard {
            result = $0
        }
    }
}
