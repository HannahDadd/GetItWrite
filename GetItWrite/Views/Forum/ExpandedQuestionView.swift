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
    @State private var errorMessage: String = ""
    let question: Question

    var body: some View {
        switch result {
        case .success(let replies):
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    //UsersDetails(username: question.questionerName, colour: question.questionerColour)
                    Text(question.question).font(.headline)
                    ReportAndBlockView(content: question, contentType: .questions, toBeBlockedUserId: question.questionerId, imageScale: .small)
                    Spacer()
                    HStack {
                        //Text(question.formatDate()).font(.caption).foregroundColor(.gray)
                        Spacer()
                        Text("\(replies.count) replies").font(.caption).foregroundColor(.gray)
                    }
                    Divider()
                }
                    ForEach(replies, id: \.id) { r in
                        VStack(alignment: .leading, spacing: 12) {
                            UsersDetails(username: r.replierName, colour: r.replierColour)
                            Text(r.reply)
                            ReportAndBlockView(content: r, contentType: .replies, toBeBlockedUserId: r.replierId, imageScale: .small, questionId: question.id)
                            //Text(r.formatDate()).font(.caption).foregroundColor(.gray)
                            Divider()
                        }
                    }
            }.padding()
            Spacer()
            ErrorText(errorMessage: errorMessage)
            SendBar(text: $reply, onSend: {
                if CheckInput.isStringGood(reply, 500) {
                    errorMessage = CheckInput.errorStringText(500)
                } else {
                    session.sendReply(content: reply, questionId: question.id)
                }
            })
        }
        case .failure(let error):
            ErrorView(error: error, retryHandler: loadReplies)
        case nil:
            ProgressView().onAppear(perform: loadReplies)
        }
    }
    
    private func loadReplies() {
        session.listenToReplies(questionID: question.id) {
            result = $0
        }
    }
}
