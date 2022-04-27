//
//  ContentView.swift
//  GetItWrite
//
//  Created by Hannah Dadd on 23/01/2022.
//

import SwiftUI

class AppSettings: ObservableObject {
	@Published var retry = false
}

struct ContentView: View {
	@ObservedObject var session = FirebaseSession()
	@State private var result: Result<User, Error>?
	
	init() {
		let navBarAppearance = UINavigationBarAppearance()
		navBarAppearance.configureWithOpaqueBackground()
		navBarAppearance.shadowColor = .clear
		navBarAppearance.backgroundColor = .white
		UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
	}
	
	var body: some View {
		NavigationView {
			switch result {
			case .success(_):
				FeedView().environmentObject(self.session)
					.navigationBarBackButtonHidden(true)
			case .failure(_):
				LoginView().environmentObject(session)
			case nil:
				ProgressView().onAppear(perform: getUser)
			}
		}.accentColor(Color.darkText)
	}
	
	func getUser() {
		session.listen() {
			result = $0
		}
	}
}
