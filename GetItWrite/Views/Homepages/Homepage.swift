//
//  Homepage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 02/09/2024.
//

import SwiftUI

struct Homepage: View {
    @EnvironmentObject var session: FirebaseSession

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 8) {
                HeadlineAndSubtitle(title: "Welcome, \(session.userData?.displayName ?? "")", subtitle: "Even the best writers need to feedback.")
                BulletinSection()
                AddBulletinPromo()
                PositivityCorner()
                HomeFeedForumSection()
                FrenzyHomeFeedSection(isQueries: false)
                AIPromo()
                Recs()
            }
        }
    }
}
