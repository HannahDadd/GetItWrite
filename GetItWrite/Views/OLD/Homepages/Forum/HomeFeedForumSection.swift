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
                TitleAndSubtitle(
                    title: "Join the conversation",
                    subtitle: "")
                ForEach(Array(questions.prefix(3)), id: \.id) { i in
                    LongQuestionButton(question: i)
                }
                LongArrowButton(title: "View more") {
                    showMore = true
                }.padding(.horizontal)
                NavigationLink(destination: ForumView(questions: questions), isActive: self.$showMore) {
                    EmptyView()
                }
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

struct LongQuestionButton: View {
    @EnvironmentObject var session: FirebaseSession
    var question: Question
    
    var body : some View {
        NavigationLink(destination: ExpandedQuestionView(question: question)
        ) {
            HStack {
                Text(question.question)
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Spacer()
            }
            .padding()
            .frame(height: CGFloat(75))
            .background(Color.questionbg)
            .cornerRadius(8)
            .padding(.horizontal)
        }.accentColor(Color.clear)
    }
}
