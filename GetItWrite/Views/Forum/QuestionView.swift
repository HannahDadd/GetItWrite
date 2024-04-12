//
//  QuestionView.swift
//  Get It Write
//
//  Created by Hannah Billingsley-Dadd on 12/04/2024.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var result: Result<[Reply], Error>?
    
    var body: some View {
        switch result {
        case .success(let replies):
            NavigationLink(destination: ExpandedProposalView(proposal: proposal).environmentObject(session)) {
                VStack(alignment: .leading, spacing: 8) {
                    UsersDetails(username: question.questionnerName, colour: question.questionnerColour)
                    Text(question.question).font(.headline)
                    Spacer()
                    HStack {
                        Text(question.formatDate()).font(.caption).foregroundColor(.gray)
                        Spacer()
                        Text("\(question.wordCount) words").font(.caption).foregroundColor(.gray)
                    }
                }
            }
        case .failure(let error):
            ErrorView(error: error, retryHandler: loadReplies)
        case nil:
            ProgressView().onAppear(perform: loadReplies)
        }
    }
    
    private func loadReplies() {
        session.loadQuestions() {
            result = $0
        }
    }
}
