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
    @State var showMakeQuestionView = false

    var body: some View {
        switch result {
        case .success(let questions):
            ZStack {
                List {
                    ForEach(questions, id: \.id) { i in
                        QuestionView(question: i)
                    }
                }.refreshable {
                    loadQuestions()
                }.listStyle(.plain)
            }
            .overlay(alignment: .bottomTrailing) {
                Button(action: { self.showMakeQuestionView.toggle() }) {
                    Image(systemName: "plus.app.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.lightBackground)
                }.padding()
            }
            .sheet(isPresented: self.$showMakeQuestionView) {
                CreateQuestionView(showMakeQuestionView: self.$showMakeQuestionView).environmentObject(self.session)
            }
        case .failure(let error):
            ErrorView(error: error, retryHandler: loadQuestions)
        case nil:
            ProgressView().onAppear(perform: loadQuestions)
        }
    }

    private func loadQuestions() {
        session.loadQuestions() {
            result = $0
        }
    }
}
