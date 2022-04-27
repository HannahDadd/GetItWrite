//
//  FeedView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 20/02/2022.
//

import SwiftUI

struct FeedView: View {
	@EnvironmentObject var session: FirebaseSession
	@State private var result: Result<[Work], Error>?
	@State var showingComposeMessage = false

	var body: some View {
		switch result {
		case .success(let posts):
			VStack {
				StretchedButton(text: "Request a Critique!", action: { self.showingComposeMessage.toggle() })
				List {
					ForEach(posts, id: \.id) { i in
						PostView(work: i, canCritique: true).environmentObject(session)
					}
				}
			}.listStyle(PlainListStyle()).padding()
			.sheet(isPresented: self.$showingComposeMessage) {
				MakePostView(showingComposeMessage: self.$showingComposeMessage).environmentObject(self.session)
			}
		case .failure(let error):
			ErrorView(error: error, retryHandler: loadPosts)
		case nil:
			ProgressView().onAppear(perform: loadPosts)
		}
	}

	private func loadPosts() {
		session.loadPosts() {
			result = $0
		}
	}
}
