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
					FeedView().environmentObject(self.session)
						.tabItem {
							Label("Menu", systemImage: "house")
						}

//				OrderView()
//					.tabItem {
//						Label("Order", systemImage: "pencil.and.outline")
//					}
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
