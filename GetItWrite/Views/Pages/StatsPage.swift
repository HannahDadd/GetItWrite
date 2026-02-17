//
//  SecondPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 20/10/2025.
//

import SwiftUI

struct StatsPage: View {
    @State var showAccountSheet = false
    @State var wips: [WIP]
    @State var createWIP = false
    @State var showStatsForWip: WIP? = nil
    
    init(wips: [WIP]) {
        self.wips = wips
    }
    
    var body: some View {
        VStack {
            HStack {
                HeadlineAndSubtitle(title: "Your Writing Stats", subtitle: "Writing games to keep you on top form.")
                Spacer()
                Image(systemName: "gearshape.fill")
                    .onTapGesture {
                        showAccountSheet.toggle()
                    }
            }
            .padding()
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(wips, id: \.id) { w in
                        EditableWIPView(w: w, changeWips: { wips in
                            self.wips = wips
                        })
                    }
                    GraphForWriter()
                }
                .padding()
            }
            .scrollIndicators(.hidden)
        }
        .sheet(isPresented: $createWIP) {
            NewWIP(wips: wips, action: { newWIP in
                wips = newWIP
                createWIP = false
            })
        }
        .sheet(isPresented: $showAccountSheet) {
            AccountPage()
        }
    }
}
