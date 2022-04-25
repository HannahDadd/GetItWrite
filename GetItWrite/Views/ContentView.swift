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
                FeedView().environmentObject(self.session)
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
