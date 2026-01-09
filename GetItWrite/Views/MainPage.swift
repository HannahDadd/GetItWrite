//
//  MainPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 08/08/2025.
//

import SwiftUI

struct MainPage: View {
    
    var body: some View {
        TabView {
            HomepagePage()
                .tabItem {
                    Label("", systemImage: "house.fill")
                }
            SprintPage()
                .tabItem {
                    Label("", systemImage: "pencil.and.scribble")
                }
            StatsPage()
                .tabItem {
                    Label("", systemImage: "chart.xyaxis.line")
                }
            GamesPage()
                .tabItem {
                    Label("", systemImage: "gamecontroller.fill")
                }
        }
        .navigationTitle("Get It Write")
        .accentColor(.primary)
    }
}
