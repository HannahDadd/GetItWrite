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
        if self.session.session != nil {
//                    HomeView().environmentObject(self.session)
        } else {
            NavigationView {
                LoginView().onAppear(perform: getUser)
            }
        }
    }

    func getUser() {
        self.session.listen()
    }
}
