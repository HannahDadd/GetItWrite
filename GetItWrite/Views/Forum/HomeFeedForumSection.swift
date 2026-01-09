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
            VStack {
                Text("Join the conversation")
                    .font(.title)
                    .foregroundColor(.white)
                ForEach(questions, id: \.id) { i in
                    LongQuestionButton(question: i)
                }
                LongArrowButton(title: "View More") {
                    showMore = true
                }
                
                NavigationLink(destination: ForumView(questions: questions).environmentObject(session), isActive: self.$showMore) {
                    EmptyView()
                }
            }
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
    var size: CGFloat = 50
    
    var body : some View {
        NavigationLink(destination: QuestionView(question: question).environmentObject(session)) {
            Text(question.question).bold()
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background(Color.background)
                .overlay(RoundedRectangle(cornerRadius: 3))
        }.accentColor(Color.clear)
    }
}
