//
//  FeedView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 20/02/2022.
//

import SwiftUI

struct FeedView: View {
	@EnvironmentObject var session: FirebaseSession
	@State private var result: Result<[Project], Error>?
	@State var showMakePostView = false
	@State var showMenu = false
	
	var body: some View {
		switch result {
		case .success(let posts):
			GeometryReader { geometry in
				ZStack(alignment: .leading) {
					if posts.count == 0 {
						VStack {
							Text("You have nothing to critique!")
							Spacer()
						}
					} else {
						List {
							ForEach(posts, id: \.id) { i in
								PostView(canCritique: true, project: i)
									.environmentObject(session)

							}
						}
					}.listStyle(PlainListStyle())
						.frame(width: geometry.size.width, height: geometry.size.height)
						.offset(x: self.showMenu ? geometry.size.width/2 : 0)
						.disabled(self.showMenu ? true : false)
				}
				if self.showMenu {
					SideBarView(showMenu: $showMenu).environmentObject(session).frame(width: geometry.size.width/2, height: geometry.size.height)
						.transition(.move(edge: .leading))
				}
			}.navigationBarTitleDisplayMode(.inline)
				.toolbar {
					ToolbarItem(placement: .principal) {
						HStack {
							Button(action: {
								withAnimation {
									showMenu.toggle()
								}
							}) { Image(systemName: "line.3.horizontal") }
							Spacer()
							Image("Words").resizable().aspectRatio(contentMode: .fit)
							Spacer()
							Button(action: { self.showMakePostView.toggle() }) {
								Image(systemName: "pencil.tip.crop.circle.badge.plus")
							}
						}
					}
				}.sheet(isPresented: self.$showMakePostView) {
					MakePostView(showingComposeMessage: self.$showMakePostView).environmentObject(self.session)
				}.onAppear(perform: {
					showMenu = false
					//					session.populateDatabaseFakeData()
				})
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
