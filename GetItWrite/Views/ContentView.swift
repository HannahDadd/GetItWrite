//
//  ContentView.swift
//  GetItWrite
//
//  Created by Hannah Dadd on 23/01/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var session = FirebaseSession()

    var body: some View {
        NavigationView {
            if self.session.user?.userData != nil {
                FeedView().environmentObject(self.session)
            } else {
                LoginView().environmentObject(session)
            }
        }.accentColor(Color.lighterReadable).onAppear(perform: getUser)
    }

    func getUser() {
        self.session.listen()
    }
}
