//
//  FeedView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 20/02/2022.
//

import SwiftUI

struct FeedView: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var result: Result<[RequestCritique], Error>?
    @State var showMakePostView = false
    
    var body: some View {
        if session.user == nil {
            Text("Sign in to critque other's work.")
        } else {
            switch result {
            case .success(let requestCritiques):
                List {
                    Text("Works to Critique")
                    if requestCritiques.count == 0 {
                        VStack(alignment: .leading, spacing: 24) {
                            Text("You have nothing to critique.").font(.title2)
                            FindPartnersText()
                            SendMessagesText()
                        }
                    } else {
                        ForEach(requestCritiques, id: \.id) { i in
                            RequestCritiqueView(requestCritique: i).environmentObject(session)
                            
                        }
                    }
                }.refreshable {
                    loadPosts()
                }.listStyle(PlainListStyle())
            case .failure(let error):
                ErrorView(error: error, retryHandler: loadPosts)
            case nil:
                ProgressView().onAppear(perform: loadPosts)
            }
        }
    }
    
    private func loadPosts() {
        session.loadRequestCritiques() {
            result = $0
        }
    }
}

struct RequestCritiqueView: View {
    @EnvironmentObject var session: FirebaseSession
    
    let requestCritique: RequestCritique
    
    var body: some View {
        NavigationLink(destination: GiveCritiqueView(requestCritique: requestCritique).environmentObject(session)) {
            VStack(alignment: .leading, spacing: 8) {
                Text(requestCritique.workTitle).font(.title3)
                Text(requestCritique.title).bold().frame(maxWidth: .infinity, alignment: .leading)
                Text(requestCritique.blurb).frame(maxWidth: .infinity, alignment: .leading)
                TagCloud(tags: requestCritique.genres, chosenTags: .constant([]), singleTagView: false)
                Spacer()
                HStack {
                    Text(requestCritique.formatDate()).font(.caption).foregroundColor(.gray)
                    Spacer()
                    // Todo use text to put word count here
                    //					Text(String(requestCritique.wordCount) + " words").font(.caption).foregroundColor(.gray)
                }
            }
        }
    }
}
