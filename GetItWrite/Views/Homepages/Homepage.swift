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
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                Text("Welcome, \(session.userData?.displayName ?? "")")
                    .font(.title2)
                    .padding()
                FrenzyHomeFeedSection(isQueries: false)
                PositivityCorner()
                HomeFeedForumSection()
                FrenzyHomeFeedSection(isQueries: true)
                AIPromo()
                Recs()
            }
        }
    }
}
