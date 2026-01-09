//
//  QueryHomePage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 27/01/2025.
//

import SwiftUI

struct QueryHomepage: View {
    @EnvironmentObject var session: FirebaseSession

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 8) {
                HeadlineAndSubtitle(title: "Query Corner", subtitle: "A query letter is sent to an agent or publisher to entice them to read your work.")
                QueryPromo()
                FrenzyHomeFeedSection(isQueries: true)
                SuccessfulQueryPromo()
                SuccessfulQueriesSection()
            }
        }
    }
}

struct QueryPromo: View {
    @State var showPopUp = false

    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.primary)
                .frame(width: 10)
                
            VStack(alignment: .leading) {
                Text("Written a query letter?")
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                    .foregroundColor(Color.onCardBackground)
                Spacer()
                Text("Post it here to receive feedback from your writing community.")
                    .multilineTextAlignment(.leading)
                    .font(.subheadline)
                    .foregroundColor(Color.onCardBackground)
            }
        }
        .padding()
        .background(Color.cardBackground)
        .cornerRadius(8)
        .onTapGesture { showPopUp = true }
        .shadow(radius: 5)
        .padding()
        .sheet(isPresented: self.$showPopUp) {
            CreateCritiqueFrenzy(showMakeCritiqueView: self.$showPopUp, isQueries: true)
        }
    }
}
