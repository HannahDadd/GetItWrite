//
//  ExpandedQuestionView.swift
//  Get It Write
//
//  Created by Hannah Billingsley-Dadd on 12/04/2024.
//

import SwiftUI

struct ExpandedQuestionView: View {
    @EnvironmentObject var session: FirebaseSession
    @State var reply: String = ""
    @State private var result: Result<[Reply], Error>?
    let question: Question
    let replies: [Reply]

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    UsersDetails(username: question.questionerName, colour: question.questionerColour)
                    Text(question.question).font(.headline)
                    ReportAndBlockView(content: question, contentType: .questions, toBeBlockedUserId: question.questionerId, imageScale: .small)
                    Spacer()
                    HStack {
                        Text(question.formatDate()).font(.caption).foregroundColor(.gray)
                        Spacer()
                        Text("\(replies.count) replies").font(.caption).foregroundColor(.gray)
                    }
                    Divider()
                }
                switch result {
                case .success(let rs):
                    ForEach(rs, id: \.id) { r in
                        VStack(alignment: .leading, spacing: 12) {
                            UsersDetails(username: r.replierName, colour: r.replierColour)
                            Text(r.reply)
                            ReportAndBlockView(content: r, contentType: .replies, toBeBlockedUserId: r.replierId, imageScale: .small)
                            Text(r.formatDate()).font(.caption).foregroundColor(.gray)
                            Divider()
                        }
                    }
                case .failure(let error):
                    ErrorView(error: error, retryHandler: loadReplies)
                case nil:
                    ProgressView().onAppear(perform: loadReplies)
                }
            }.padding()
            Spacer()
            SendBar(text: $reply, onSend: {
                session.sendReply(content: reply, questionId: question.id)
            })
        }
    }
    
    private func loadReplies() {
        session.listenToReplies(questionID: question.id) {
            result = $0
        }
    }
}
