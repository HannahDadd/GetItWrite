//
//  CritiqueFrenzyFeed.swift
//  Get It Write
//
//  Created by Hannah Billingsley-Dadd on 16/04/2024.
//

import SwiftUI

struct CritiqueFrenzyView: View {
    @EnvironmentObject var session: FirebaseSession
    @State var showMakeCritiqueView = false
    
    let requests: [RequestCritique]
    let isQueries: Bool
    
    var body: some View {
        ZStack {
            ScrollView {
                ForEach(requests, id: \.id) { i in
                    FrenzyListView(requestCritique: i)
                }.padding()
            }
        }
        .navigationTitle(isQueries ? "Query Frenzy" : "Critique Frenzy")
        .overlay(alignment: .bottomTrailing) {
            Button(action: { self.showMakeCritiqueView.toggle() }) {
                Image(systemName: "plus.app.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.primary)
            }.padding()
        }
        .sheet(isPresented: self.$showMakeCritiqueView) {
            CreateCritiqueFrenzy(showMakeCritiqueView: self.$showMakeCritiqueView, isQueries: isQueries)
        }
    }
}

struct FrenzyListView: View {
    @EnvironmentObject var session: FirebaseSession
    let requestCritique: RequestCritique
    
    var body: some View {
        NavigationLink(
            destination:
                GiveCritiqueView(requestCritique: requestCritique)) {
                    VStack(alignment: .leading, spacing: 8) {
                        //            Image(systemName: icon)
                        //                .resizable()
                        //                .aspectRatio(contentMode: .fit)
                        //                .frame(height: 15)
                        Text(requestCritique.genres.joined(separator: ", "))
                            .foregroundColor(Color.onCardBackground)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                        Spacer()
                        HStack {
                            Spacer()
                            Text("\(requestCritique.text.components(separatedBy: .whitespacesAndNewlines).count) words")
                                .padding(6)
                                .font(.caption)
                                .background(Color.primary)
                                .foregroundColor(Color.onPrimary)
                                .clipShape(.capsule)
                        }
                    }
                    .padding()
                    .frame(height: 100)
                    .background(Color.cardBackground)
                    .cornerRadius(8)
                }
    }
}
