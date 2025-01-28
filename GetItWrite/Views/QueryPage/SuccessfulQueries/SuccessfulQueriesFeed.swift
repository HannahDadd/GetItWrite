//
//  SuccessfulQueriesFeed.swift
//  Get It Write
//
//  Created by Hannah Dadd on 27/01/2025.
//

import SwiftUI

struct SuccessfulQueriesFeed: View {
    @EnvironmentObject var session: FirebaseSession
    @State var showPopUp = false
    
    let requests: [SuccessfulQuery]
    
    var body: some View {
        ZStack {
            ScrollView {
                ForEach(requests, id: \.id) { i in
                    SuccessfulQueryListView(successfulQuery: i)
                }.padding()
            }
        }
        .navigationTitle("Successful Query")
        .overlay(alignment: .bottomTrailing) {
            Button(action: { self.showPopUp.toggle() }) {
                Image(systemName: "plus.app.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.lightBackground)
            }.padding()
        }
        .sheet(isPresented: self.$showPopUp) {
            CreateSuccessfulQuery(showPopUp: self.$showPopUp)
        }
    }
}

struct SuccessfulQueryListView: View {
    @EnvironmentObject var session: FirebaseSession
    let successfulQuery: SuccessfulQuery
    
    var body: some View {
        NavigationLink(
            destination:
                SuccessfulQueryView(successfulQuery: successfulQuery)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(successfulQuery.text)
                            .foregroundColor(Color.onCardBackground)
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                        Spacer()
                        HStack {
                            Spacer()
                            Text("\(successfulQuery.text.components(separatedBy: .whitespacesAndNewlines).count) words")
                                .padding(6)
                                .font(.caption)
                                .background(Color.primary)
                                .foregroundColor(Color.onPrimary)
                                .clipShape(.capsule)
                        }
                    }
                    .padding()
                    .frame(height: 150)
                    .background(Color.cardBackground)
                    .cornerRadius(8)
                }
    }
}
