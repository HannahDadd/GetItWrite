//
//  FeedView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 20/02/2022.
//

import SwiftUI

struct FeedView: View {
	@EnvironmentObject var session: FirebaseSession
	@State private var result: Result<[RequestCritique], Error>?
	@State var showMakePostView = false
	@State var showMenu = false
	
	var body: some View {
		switch result {
		case .success(let requestCritiques):
			GeometryReader { geometry in
				ZStack(alignment: .leading) {
					List {
                        Text("Works to Critique")
						if requestCritiques.count == 0 {
							VStack(alignment: .leading, spacing: 24) {
								Text("You have nothing to critique.").font(.title2)
                                FindPartnersText()
                                SendMessagesText()
							}
						} else {
							ForEach(requestCritiques, id: \.id) { i in
								RequestCritiqueView(requestCritique: i).environmentObject(session)

							}
						}
					}.refreshable {
						loadPosts()
					}.listStyle(PlainListStyle()).frame(width: geometry.size.width, height: geometry.size.height)
						.offset(x: self.showMenu ? geometry.size.width/2 : 0)
						.disabled(self.showMenu ? true : false)
					if self.showMenu {
						SideBarView(showMenu: $showMenu).environmentObject(session).frame(width: geometry.size.width/2, height: geometry.size.height)
							.transition(.move(edge: .leading))
					}
				}
			}.navigationBarTitleDisplayMode(.inline).toolbar {
				ToolbarItem(placement: .principal) {
					Image("Words").resizable().aspectRatio(contentMode: .fit)
				}
			}.navigationBarItems(
				leading: Button(action: {
					withAnimation {
						showMenu.toggle()
					}
				}) { Image(systemName: "line.3.horizontal") }).onAppear(perform: {
					showMenu = false
					//session.populateDatabaseFakeData()
				}).navigationBarBackButtonHidden(true)
		case .failure(let error):
			ErrorView(error: error, retryHandler: loadPosts)
		case nil:
			ProgressView().onAppear(perform: loadPosts)
		}
	}

	private func loadPosts() {
		session.loadRequestCritiques() {
			result = $0
		}
	}
}

struct RequestCritiqueView: View {
	@EnvironmentObject var session: FirebaseSession

	let requestCritique: RequestCritique

	var body: some View {
		NavigationLink(destination: GiveCritiqueView(requestCritique: requestCritique).environmentObject(session)) {
			VStack(alignment: .leading, spacing: 8) {
				Text(requestCritique.workTitle).font(.title3)
				Text(requestCritique.title).bold().frame(maxWidth: .infinity, alignment: .leading)
				Text(requestCritique.blurb).frame(maxWidth: .infinity, alignment: .leading)
				TagCloud(tags: requestCritique.genres, chosenTags: .constant([]), singleTagView: false)
				Spacer()
				HStack {
					Text(requestCritique.formatDate()).font(.caption).foregroundColor(.gray)
					Spacer()
					// Todo use text to put word count here
					//					Text(String(requestCritique.wordCount) + " words").font(.caption).foregroundColor(.gray)
				}
			}
		}
	}
}
