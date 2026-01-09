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
                Text("")
                    .font(.title)
                    .foregroundColor(.white)
                ForEach(Array(critiques.prefix(5)), id: \.id) { i in
                    LongCritiquedButton(critique: i)
                }
                LongArrowButton(title: "View More") {
                    showMore = true
                }
                
                NavigationLink(destination: CritiquesView(critiques: critiques).environmentObject(session), isActive: self.$showMore) {
                    EmptyView()
                }
            }
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
    var size: CGFloat = 50
    
    var body : some View {
        NavigationLink(destination: CritiqueView(critique: critique).environmentObject(session)) {
            Text(critique.title).bold()
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background(Color.background)
                .overlay(RoundedRectangle(cornerRadius: 3))
        }.accentColor(Color.clear)
    }
}
