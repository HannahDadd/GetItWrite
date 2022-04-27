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
	@State var showMenu = false

	var body: some View {
		switch result {
		case .success(let posts):
			GeometryReader { geometry in
				ZStack(alignment: .leading) {
					List {
						ForEach(posts, id: \.id) { i in
							PostView(work: i, canCritique: true).environmentObject(session)
						}
					}.listStyle(PlainListStyle()).padding()
						.navigationBarTitleDisplayMode(.inline)
						.toolbar {
							ToolbarItem(placement: .principal) {
								HStack {
									Button(action: {
										withAnimation {
											showMenu = true
										}
									}) {
										Image(systemName: "line.3.horizontal")
									}
									Spacer()
									Image("Words").resizable()
										.aspectRatio(contentMode: .fit)
									Spacer()
									Button(action: { self.showingComposeMessage.toggle() }) {
										Image(systemName: "pencil.tip.crop.circle.badge.plus")
									}
								}
							}
						}.sheet(isPresented: self.$showingComposeMessage) {
							MakePostView(showingComposeMessage: self.$showingComposeMessage).environmentObject(self.session)
						}
				}.frame(width: geometry.size.width, height: geometry.size.height)
					.offset(x: self.showMenu ? geometry.size.width/2 : 0)
					.disabled(self.showMenu ? true : false)
					.transition(.move(edge: .leading))
				if self.showMenu {
					SideBarView().frame(width: geometry.size.width/2)
				}
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
