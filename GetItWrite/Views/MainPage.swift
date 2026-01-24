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
                    Label("", systemImage: "alarm.fill")
                }
            LeaderboardPage()
                .tabItem {
                    Label("", systemImage: "chart.bar.yaxis")
                }
            StatsPage()
                .tabItem {
                    Label("", systemImage: "chart.xyaxis.line")
                }
        }
        .navigationTitle("Get It Write")
        .accentColor(.primary)
    }
}
