//
//  CritiquesView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 27/04/2022.
//

import SwiftUI

struct CritiquesFeedView: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var result: Result<[Critique], Error>?
    @State var showMore = false

    var body: some View {
        switch result {
        case .success(let critiques):
            VStack {
                Text("Your work, critiqued by your writing friends.")
                    .font(.headline)
                    .foregroundColor(Color.onSecondary)
                ForEach(Array(critiques.prefix(3)), id: \.id) { i in
                    LongCritiquedButton(critique: i)
                }
                LongArrowButton(title: "View more") {
                    showMore = true
                }
                
                NavigationLink(destination: CritiquesView(critiques: critiques).environmentObject(session), isActive: self.$showMore) {
                    EmptyView()
                }
            }.padding()
            .background(Color.secondary)
        case .failure(let error):
            ErrorView(error: error, retryHandler: loadCritiques)
        case nil:
            ProgressView().onAppear(perform: loadCritiques)
        }
    }

    private func loadCritiques() {
        session.loadCritiques() {
            result = $0
        }
    }
}

struct CritiquesView: View {
    let critiques: [Critique]

	var body: some View {
        List {
            ForEach(critiques, id: \.id) { i in
                CritiqueView(critique: i)
            }
        }.listStyle(.plain)
            .navigationBarTitle("Critiques", displayMode: .inline)
	}
}

struct LongCritiquedButton: View {
    @EnvironmentObject var session: FirebaseSession
    var critique: Critique
    
    var body : some View {
        NavigationLink(destination: ViewCritiqueView(critique: critique)) {
            VStack(alignment: .leading) {
                Text(critique.projectTitle)
                    .foregroundColor(Color.onCardBackground)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Spacer()
                HStack {
                    Spacer()
                    Text("\(critique.comments.count) comments")
                        .padding(6)
                        .font(.caption)
                        .background(Color.primary)
                        .foregroundColor(Color.onPrimary)
                        .clipShape(.capsule)
                }
            }
            .padding()
            .frame(height: CGFloat(100))
            .frame(maxWidth: .infinity)
            .background(Color.cardBackground)
            .cornerRadius(8)
        }.accentColor(Color.clear)
    }
}
