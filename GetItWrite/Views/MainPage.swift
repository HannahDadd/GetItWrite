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
                    Label("Menu", systemImage: "list.dash")
                }

            SecondPage()
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
            
            ThirdPage()
                .tabItem {
                    Label("Writing Games", systemImage: "gamecontroller.fill")
                }
        }
        .navigationTitle("Get It Write")
        .accentColor(.primary)
    }
}
