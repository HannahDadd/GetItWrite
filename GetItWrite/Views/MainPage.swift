//
//  MainPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 08/08/2025.
//

import SwiftUI

struct MainPage: View {
    let wips: [WIP]
    
    var body: some View {
        TabView {
            HomepagePage(wips: wips)
                .tabItem {
                    Label("", systemImage: "house.fill")
                }
            SprintPage()
                .tabItem {
                    Label("", systemImage: "alarm.fill")
                }
            BadgePage()
                .tabItem {
                    Label("", systemImage: "chart.bar.yaxis")
                }
            StatsPage(wips: wips)
                .tabItem {
                    Label("", systemImage: "chart.xyaxis.line")
                }
        }
        .navigationTitle("Get It Write")
        .accentColor(.primary)
    }
}
