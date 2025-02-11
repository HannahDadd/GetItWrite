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
    
    let genre: String
    
    var body: some View {
        switch result {
        case .success(let proposals):
            ZStack {
                ScrollView {
                    ForEach(proposals, id: \.id) { i in
                        ProposalView(proposal: i).environmentObject(session)
                    }
                }.refreshable {
                    loadProposals()
                }
                .navigationTitle(genre)
            }
            .overlay(alignment: .bottomTrailing) {
                Button(action: { self.showMakeProposalView.toggle() }) {
                    Image(systemName: "plus.app.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.primary)
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
        if genre == "All" {
            session.loadProposals() {
                result = $0
            }
        } else {
            session.loadProposals(genre: genre) {
                result = $0
            }
        }
    }
}
