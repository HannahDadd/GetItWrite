//
//  ContentView.swift
//  GetItWrite
//
//  Created by Hannah Dadd on 23/01/2022.
//

import SwiftUI

struct ContentView: View {
	@StateObject var session = FirebaseSession()
	@State private var result: Result<User, Error>?
	
	init() {
		let navBarAppearance = UINavigationBarAppearance()
		navBarAppearance.configureWithOpaqueBackground()
		navBarAppearance.shadowColor = .clear
		navBarAppearance.backgroundColor = .white
		UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
	}
	
	var body: some View {
		NavigationStack {
			switch result {
			case .success(_):
                LandingPage()
					.navigationBarBackButtonHidden(true)
                    .toolbarBackground(
                        Color.secondary,
                    for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
			case .failure(_):
                LoginView().environmentObject(session)
			case nil:
				Text("You'll get there, one word at a time. ")
                    .onAppear(perform: getUser)
			}
		}
        .environmentObject(session)
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(Color.darkText)
	}
	
	func getUser() {
		session.listen() {
			result = $0
		}
	}
}
