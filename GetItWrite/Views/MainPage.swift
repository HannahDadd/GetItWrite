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
            FirstPage()
                .tabItem {
                    Label("Goals", systemImage: "house.fill")
                }
            SecondPage()
                .tabItem {
                    Label("Graphs", systemImage: "chart.xyaxis.line")
                }
            BadgePage()
                .tabItem {
                    Label("Badges", systemImage: "shield.fill")
                }
            ThirdPage()
                .tabItem {
                    Label("Games", systemImage: "gamecontroller.fill")
                }
        }
        .navigationTitle("Get It Write")
        .accentColor(.primary)
    }
}
