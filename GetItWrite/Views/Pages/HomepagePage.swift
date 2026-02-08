//
//  Homepage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 20/10/2025.
//

import SwiftUI

struct HomepagePage: View {
    @StateObject private var navigationManager = NavigationManager<HomepageRoute>()
    @State var path = NavigationPath([HomepageRoute.tally])
    @State var createWIP = false
    @State var wips: [WIP]
    
    init(wips: [WIP]) {
        self.wips = wips
    }
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(spacing: 20) {
                        HeadlineAndSubtitle(title: "Hey, future best selling author", subtitle: "Let's get that manuscript written.")
                        Text("Your username: \(wips.count)")
                            .bold()
                            .multilineTextAlignment(.leading)
                        TallyCTA(action: {
                            navigationManager.navigate(to: .tally)
                        })
                        NotificationCTA()
                        StreakCTA()
                        Divider()
                        ForEach(wips, id: \.id) { w in
                            EditableWIPView(w: w, changeWips: { wips in
                                self.wips = wips
                            })
                        }
                        StretchedButton(text: "Create Project", action: {
                            createWIP = true
                        })
                    }
                    .padding()
                }
                .scrollIndicators(.hidden)
            }
            .navigationDestination(for: HomepageRoute.self) { route in
                switch route {
                case .tally:
                    ExtendTally(action: {
                        navigationManager.reset()
                    })
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
            .sheet(isPresented: $createWIP) {
                NewWIP(wips: wips, action: { newWIP in
                    wips = newWIP
                    createWIP = false
                })
            }
        }
    }
}

enum HomepageRoute {
    case tally
}
