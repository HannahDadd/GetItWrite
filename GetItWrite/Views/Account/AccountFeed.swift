//
//  AccountFeed.swift
//  Get It Write
//
//  Created by Hannah Dadd on 02/09/2024.
//

import SwiftUI

struct AccountFeed: View {
    @EnvironmentObject var session: FirebaseSession

    var body: some View {
        VStack {
            NavigationLink(destination: ProposalsFeed(genre: "All").environmentObject(session)) {
                AllChatsView()
            }
            MakeWIP()
            WIPs()
            CritiquesFeedView()
            FrenziesCritiqued(isQueries: false)
            FrenziesCritiqued(isQueries: true)
        }
    }
}
