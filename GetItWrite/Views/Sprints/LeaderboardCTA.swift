//
//  LeaderboardCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 11/02/2026.
//

import SwiftUI

struct LeaderboardCTA: View {
    @AppStorage(UserDefaultNames.username.rawValue) private var username = ""
    @EnvironmentObject var networking: SprintNetworking
    
    @State var sprint: Sprint? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Most recent sprint leaderboard")
                .textCase(.uppercase)
            if let sprint = sprint {
                ForEach(sprint.participants.sorted(by: >), id: \.key) { key, value in
                    HStack {
                        Text(key)
                            .font(Font.custom("Bellfair-Regular", size: 20))
                        Spacer()
                        Text("\(value) words")
                            .font(Font.custom("Bellfair-Regular", size: 20))
                    }
                    Divider()
                }
            }
            VStack {
                EmptyView()
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .onAppear {
            networking.getLastSprint(completion: { s in
                sprint = s
            })
        }
    }
}
