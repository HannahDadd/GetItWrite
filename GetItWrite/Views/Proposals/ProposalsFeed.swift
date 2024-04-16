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
            ZStack {
                List {
                    ForEach(proposals, id: \.id) { i in
                        ProposalView(proposal: i).environmentObject(session)
                    }
                }.refreshable {
                    loadProposals()
                }.listStyle(.plain)
            }
            .overlay(alignment: .bottomTrailing) {
                Button(action: { self.showMakeProposalView.toggle() }) {
                    Image(systemName: "plus.app.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.lightBackground)
                }.padding()
            }
            .sheet(isPresented: self.$showMakeProposalView) {
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
