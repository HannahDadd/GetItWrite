//
//  ContentView.swift
//  GetItWrite
//
//  Created by Hannah Dadd on 23/01/2022.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var session = FirebaseSession()
	@State private var result: Result<User?, Error>?
	
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
                LandingPage()
                    .environmentObject(session)
					.navigationBarBackButtonHidden(true)
			case .failure(let error):
				ErrorView(error: error, retryHandler: getUser)
			case nil:
				ProgressView().onAppear(perform: getUser)
			}
		}.navigationViewStyle(StackNavigationViewStyle()).accentColor(Color.darkText)
	}
	
	func getUser() {
		session.listen() {
			result = $0
		}
	}
}
