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
						Text(i.title)
						//                        UserView(username: i.posterUsername, imageUrl: i.posterImage, userId: i.posterId)
						//                        PostView(post: i, hasLink: true).environmentObject(self.session)
					}
				}
			}.navigationBarBackButtonHidden(true).navigationBarItems(
				leading: Button(action: {
					self.session.logOut()
				}) { Text("Logout") }
			).listStyle(PlainListStyle())
				.sheet(isPresented: self.$showingComposeMessage) {
					MakePostView(showingComposeMessage: self.$showingComposeMessage).environmentObject(self.session)
				}.navigationBarTitle(Text("Critiques"), displayMode: .inline)
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
