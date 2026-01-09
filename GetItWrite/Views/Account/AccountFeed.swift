//
//  AccountFeed.swift
//  Get It Write
//
//  Created by Hannah Dadd on 02/09/2024.
//

import SwiftUI

struct AccountFeed: View {
    @EnvironmentObject var session: FirebaseSession
    @State var showMore = false

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 8) {
                if let user = session.userData {
                    StatsView(user: user)
                }
                LongArrowButton(title: "Messages", isMessages: true, action: {
                    showMore = true
                }).padding(.horizontal)
                NavigationLink(destination: AllChatsView(), isActive: self.$showMore) {
                    EmptyView()
                }
                MakeWIP()
                WIPs()
                CritiquesFeedView()
                FrenziesCritiqued(isQueries: false)
                PositivitiesCritiqued()
                FrenziesCritiqued(isQueries: true)
            }
        }
    }
}
