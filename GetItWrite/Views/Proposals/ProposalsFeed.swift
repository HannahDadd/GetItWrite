//
//  ProposalsFeed.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 16/05/2022.
//

import SwiftUI

struct ProposalsFeed: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var result: Result<[Proposal], Error>?
    @State var showMakeProposalView = false
    
    var body: some View {
        switch result {
        case .success(let proposals):
            List {
                StretchedButton(text: "Ask for Critiques", action: { self.showMakeProposalView.toggle() })
                if proposals.count == 0 {
                    Text("There are currently no requests for critiques.\n\nWhy not make one?")
                } else {
                    ForEach(proposals, id: \.id) { i in
                        ProposalView(proposal: i).environmentObject(session)
                    }
                }
            }.refreshable {
                loadProposals()
            }.listStyle(.plain).toolbar {
                ToolbarItem(placement: .principal) {
                    Image("Proposals").resizable().aspectRatio(contentMode: .fit)
                }
            }.sheet(isPresented: self.$showMakeProposalView) {
                MakeProposalsView(showMakeProposalView: self.$showMakeProposalView).environmentObject(self.session)
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
