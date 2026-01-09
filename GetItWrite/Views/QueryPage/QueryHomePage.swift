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
        PicturePromo(text: "Written a Query Letter?", buttonText: "Get feedback", picture: "addQueryPromo") {
            showPopUp = true
        }
        .sheet(isPresented: self.$showPopUp) {
            CreateCritiqueFrenzy(showMakeCritiqueView: self.$showPopUp, isQueries: true)
        }
    }
}
