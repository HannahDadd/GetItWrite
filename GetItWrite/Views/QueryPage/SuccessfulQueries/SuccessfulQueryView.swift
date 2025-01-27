//
//  SuccessfulQuery.swift
//  Get It Write
//
//  Created by Hannah Dadd on 27/01/2025.
//

import SwiftUI
import FirebaseFirestore

struct SuccessfulQueryView: View {
    @EnvironmentObject var session: FirebaseSession
    
    let successfulQuery: SuccessfulQuery

    var body: some View {
        ScrollView {
            Text(successfulQuery.text).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 8)
            ReportAndBlockView(content: successfulQuery, contentType: .successfulQuery, toBeBlockedUserId: successfulQuery.writerId, imageScale: .large)
            Spacer()
            VStack {
                Divider()
                ErrorText(errorMessage: errorMessage)
            }
            NavigationLink(destination: LandingPage().environmentObject(session), isActive: self.$backToFeed) {
                EmptyView()
            }
        }
        .navigationTitle("successful Query")
        .padding()
        .alert("Something went wrong!", isPresented: $showingError) {
            Button("OK", role: .cancel) { }
        }
    }
}
