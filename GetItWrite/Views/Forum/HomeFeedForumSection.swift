//
//  HomeFeedForumSection.swift
//  Get It Write
//
//  Created by Hannah Dadd on 02/09/2024.
//

import SwiftUI

struct HomeFeedForumSection: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var result: Result<[Question], Error>?
    @State var showMore = false

    var body: some View {
        switch result {
        case .success(let questions):
            VStack(alignment: .leading) {
                Text("Join the conversation")
                    .font(.headline)
                    .foregroundColor(Color.onSecondary)
                ForEach(Array(questions.prefix(3)), id: \.id) { i in
                    LongQuestionButton(question: i)
                }
                LongArrowButton(title: "View more") {
                    showMore = true
                }
                NavigationLink(destination: ForumView(questions: questions), isActive: self.$showMore) {
                    EmptyView()
                }
            }.padding()
            .background(Color.secondary)
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

struct LongQuestionButton: View {
    @EnvironmentObject var session: FirebaseSession
    var question: Question
    
    var body : some View {
        NavigationLink(destination: ExpandedQuestionView(question: question)
        ) {
            HStack {
                Text(question.question)
                    .foregroundColor(Color.onCardBackground)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
//                    .frame(maxWidth: .infinity)
                Spacer()
            }
            .padding()
            .frame(height: CGFloat(75))
            .background(Color.cardBackground)
            .cornerRadius(8)
        }.accentColor(Color.clear)
    }
}
