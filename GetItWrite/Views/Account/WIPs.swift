//
//  WIPs.swift
//  Get It Write
//
//  Created by Hannah Dadd on 02/09/2024.
//

import SwiftUI

struct MakeWIP: View {
    @EnvironmentObject var session: FirebaseSession
    @State var showPopUp = false

    var body: some View {
        VStack {
            ImagePromo(image: "statsbg", text: "", bubbleText: "") {
                showPopUp = true
            }
        }
        .sheet(isPresented: self.$showPopUp) {
            MakeProposalsView(showMakeProposalView: self.$showPopUp).environmentObject(self.session)
        }
    }
}

struct WIPs: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var result: Result<[Proposal], Error>?
    
    var body: some View {
        switch result {
        case .success(let critiques):
            TitleAndSubtitle(
                title: "",
                subtitle: "")
            HStack {
                ForEach(critiques, id: \.id) { c in
                    NavigationLink(
                        destination:
                            ProposalView(proposal: c)
                            .environmentObject(session)) {
                        CarouselCard(
                            icon: "book.closed.fill",
                            title: c.title,
                            bubbleText: "\(c.wordCount) words"
                        )
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
        session.loadUserProposals {
            result = $0
        }
    }
}
