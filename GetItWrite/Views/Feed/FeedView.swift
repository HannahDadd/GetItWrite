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
	@State var showingComposeMessage = false
	@State var showMenu = false
	@State var alreadyCritiqued = false
	@State var ownWork = false
	@State var giveCritiquesView = false
	
	var body: some View {
		switch result {
		case .success(let posts):
			GeometryReader { geometry in
				ZStack(alignment: .leading) {
					List {
						ForEach(posts, id: \.id) { i in
							PostView(project: i).environmentObject(session)
								.onTapGesture {
									if i.critiques.contains(session.userData?.id ?? "") {
										alreadyCritiqued = true
									} else if i.writerId == session.userData?.id ?? "" {
										ownWork = true
									} else {
										giveCritiquesView = true
									}
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
							Button(action: { self.showingComposeMessage.toggle() }) {
								Image(systemName: "pencil.tip.crop.circle.badge.plus")
							}
						}
					}
				}.sheet(isPresented: self.$showingComposeMessage) {
					MakePostView(showingComposeMessage: self.$showingComposeMessage).environmentObject(self.session)
				}.onAppear(perform: {
					showMenu = false
					//				session.populateDatabaseFakeData()
				}).alert("You've already Critiqued this project", isPresented: $alreadyCritiqued) {
					Button("OK", role: .cancel) { }
				}.alert("You cannot critique your own work", isPresented: $ownWork) {
					Button("OK", role: .cancel) { }
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
