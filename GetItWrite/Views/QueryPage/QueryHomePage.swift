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
                HeadlineAndSubtitle(title: "Query Corner", subtitle: "Perfect your query letter before sending it out.")
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
        VStack(alignment: .leading, spacing: 2) {
            Image("addQueryPromo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(4)
            Text("Written a Query Letter?")
                .multilineTextAlignment(.leading)
                .textCase(.uppercase)
            HStack {
                Spacer()
                Button("Get some feedback") {
                    showPopUp = true
                }
                .buttonStyle(BubbleButton())
            }
        }
        .padding()
        .sheet(isPresented: self.$showPopUp) {
            CreateCritiqueFrenzy(showMakeCritiqueView: self.$showPopUp, isQueries: true)
        }
    }
}
