//
//  LandingPage.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 15/07/2023.
//

import SwiftUI

struct LandingPage: View {
    @EnvironmentObject var session: FirebaseSession
    @State var showMenu = false
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            Homepage().environmentObject(session)
                .tabItem {
                    Image(systemName: "house.fill")
                }
                .tag(0)
            QueryHomepage().environmentObject(session)
                .tabItem {
                    Image(systemName: "envelope.fill")
                }
                .tag(1)
            SearchPage().environmentObject(session)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(2)
            AccountFeed().environmentObject(session)
                .tabItem {
                    Image(systemName: "person.fill")
                }
                .tag(3)
            AllChatsView().environmentObject(session)
                .tabItem {
                    Image(systemName: "message.fill")
                }
                .tag(4)
        }
        .accentColor(Color.primary)
    }
}
