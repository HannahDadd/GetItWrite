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

    var body: some View {
        NavigationView {
            switch result {
            case .success(_):
				TabView {
					CritiquesView().environmentObject(self.session)
						.tabItem {
							Label("Critiques", systemImage: "pencil.and.outline")
						}
					FeedView().environmentObject(self.session)
						.tabItem {
							Label("Home", systemImage: "house")
						}
					ProfileView().environmentObject(self.session)
						.tabItem {
							Label("Profile", systemImage: "person.fill")
						}
				}
            case .failure(_):
                LoginView().environmentObject(session)
            case nil:
                ProgressView().onAppear(perform: getUser)
            }
		}.accentColor(Color.darkBackground)
    }

    func getUser() {
        session.listen() {
            result = $0
        }
    }
}
