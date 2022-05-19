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
	@State var showingComposeMessage = false

	var body: some View {
		switch result {
		case .success(let proposals):
			LazyVStack {
				ForEach(proposals, id: \.id) { i in
					ProposalView(proposal: i).environmentObject(session)
				}
			}.listStyle(PlainListStyle())
				.navigationBarTitle("Proposals", displayMode: .inline)
				.sheet(isPresented: self.$showingComposeMessage) {
					MakePostView(showingComposeMessage: self.$showingComposeMessage).environmentObject(self.session)
				}.onAppear(perform: {
					session.populateDatabaseFakeData()
				})
		case .failure(let error):
			ErrorView(error: error, retryHandler: loadProposals)
		case nil:
			ProgressView().onAppear(perform: loadProposals)
		}
	}

	private func loadProposals() {
		//		session.loadPosts() {
		//			result = $0
		//		}
	}
}
