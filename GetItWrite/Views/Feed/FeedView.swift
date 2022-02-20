//
//  FeedView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 20/02/2022.
//

import SwiftUI

struct FeedView: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var result: Result<[Work], Error>?
    @State var showingComposeMessage = false

    var body: some View {
        switch result {
        case .success(let posts):
            NavigationView {
                List {
                    Button(action: { self.showingComposeMessage.toggle() }) {
                        HStack {
                            Text("What's on your mind?")
                            Spacer()
                            Image(systemName: "plus").foregroundColor(Color.init("WordColour"))
                        }
                    }
                    ForEach(posts, id: \.id) { i in
                        Text(i.text)
//                        UserView(username: i.posterUsername, imageUrl: i.posterImage, userId: i.posterId)
//                        PostView(post: i, hasLink: true).environmentObject(self.session)
                    }
                }.listStyle(PlainListStyle()).background(Color.init("BackgroundColour"))
                .sheet(isPresented: self.$showingComposeMessage) {
//                    MakePostView(showingComposeMessage: self.$showingComposeMessage).environmentObject(self.session)
                }.navigationBarTitle(Text("Feed"), displayMode: .inline)
            }
        case .failure(let error):
            ErrorView(error: error, retryHandler: loadPosts)
        case nil:
            ProgressView().onAppear(perform: loadPosts)
        }
    }

    private func loadPosts() {
        session.loadPosts() {
            result = $0
        }
    }
}
