//
//  ForumView.swift
//  Get It Write
//
//  Created by Hannah Billingsley-Dadd on 12/04/2024.
//

import SwiftUI

struct ForumView: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var result: Result<[Question], Error>?

    var body: some View {
        switch result {
        case .success(let questions):
            List {
                ForEach(questions, id: \.id) { i in
                    CritiqueView(critique: i)
                }
            }.refreshable {
                loadCritiques()
            }.listStyle(.plain)
                .navigationBarTitle("Critiques", displayMode: .inline)
        case .failure(let error):
            ErrorView(error: error, retryHandler: loadCritiques)
        case nil:
            ProgressView().onAppear(perform: loadCritiques)
        }
    }

    private func loadQuestions() {
        session.loadQuestions() {
            result = $0
        }
    }
}
