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
        if self.session.user != nil {
//                    HomeView().environmentObject(self.session)
        } else {
            NavigationView {
                LoginView().environmentObject(session).onAppear(perform: getUser)
            }.accentColor(Color.lighterReadable)
        }
    }

    func getUser() {
        self.session.listen()
    }
}
