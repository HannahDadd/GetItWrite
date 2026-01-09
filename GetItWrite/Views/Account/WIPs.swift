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
            ImagePromo(image: "statsbg", text: "Take your writing to the next level.", bubbleText: "Find critique partners for your WIP") {
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
            VStack {
                TitleAndSubtitle(
                    title: "Your WIPs",
                    subtitle: "Your current writing projects.")
                if !critiques.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(critiques, id: \.id) { c in
                                NavigationLink(
                                    destination:
                                        ExpandedProposalView(proposal: c)
                                        .environmentObject(session)) {
                                            BookCard(proposal: c)
                                        }
                            }
                        }.padding()
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
