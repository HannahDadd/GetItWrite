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
    let question: Question
    let replies: [Reply]

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    UsersDetails(username: question.questionerName, colour: question.questionerColour)
                    Text(question.question).font(.headline)
                    Spacer()
                    HStack {
                        Text(question.formatDate()).font(.caption).foregroundColor(.gray)
                        Spacer()
                        Text("\(replies.count) replies").font(.caption).foregroundColor(.gray)
                    }
                    Divider()
                }
                ForEach(replies, id: \.id) { r in
                    VStack(alignment: .leading, spacing: 12) {
                        UsersDetails(username: r.replierName, colour: r.replierColour)
                        Text(r.reply)
                        Text(r.formatDate()).font(.caption).foregroundColor(.gray)
                        Divider()
                    }
                }
            }.padding()
            Spacer()
            SendBar(text: $reply, onSend: {
                session.sendReply(content: reply, questionId: question.id)
            })
        }
    }
}
