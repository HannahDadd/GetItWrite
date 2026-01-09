//
//  SecondPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 20/10/2025.
//

import SwiftUI

struct StatsPage: View {
    @State var WIPs: [WIP] = []
    @State var createWIP = false
    @State var showStatsForWip: WIP? = nil
    
    var body: some View {
        VStack {
            HeadlineAndSubtitle(title: "Your Writing Stats", subtitle: "Writing games to keep you on top form.")
            ScrollView {
                VStack(spacing: 20) {
                    WIPsCTA()
                        .id(2)
                    GraphForWriter()
                        .id(3)
                }
                .padding()
            }
            .scrollIndicators(.hidden)
        }
        .sheet(isPresented: $createWIP) {
            NewWIP(wips: WIPs, action: { newWIP in
                WIPs = newWIP
                createWIP = false
            })
        }
    }
}
