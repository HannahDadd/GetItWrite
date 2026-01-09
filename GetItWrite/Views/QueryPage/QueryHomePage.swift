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
                VStack(alignment: .leading, spacing: 4) {
                    Text("Query Corner")
                        .font(.title2)
                    Text("A query letter is sent to an agent or publisher to get them interested in your work. It consist of a short blurb and some facts about the book.")
                        .multilineTextAlignment(.leading)
                        .font(.subheadline)
                }
                .padding()
                QueryPromo()
                FrenzyHomeFeedSection(isQueries: true)
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
        .shadow(radius: 5)
        .padding()
        .sheet(isPresented: self.$showPopUp) {
            CreateCritiqueFrenzy(showMakeCritiqueView: self.$showPopUp, isQueries: true)
        }
    }
}
