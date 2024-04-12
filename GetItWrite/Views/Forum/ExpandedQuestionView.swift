//
//  ExpandedQuestionView.swift
//  Get It Write
//
//  Created by Hannah Billingsley-Dadd on 12/04/2024.
//

import SwiftUI

struct ExpandedQuestionView: View {
    let question: Question
    let replies: [Reply]
    @State var reply: String = ""

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    UsersDetails(username: question.questionnerName, colour: question.questionnerColour)
                    Text(question.question).font(.headline)
                    Spacer()
                    HStack {
                        Text(question.formatDate()).font(.caption).foregroundColor(.gray)
                        Spacer()
                        Text("\(question.wordCount) words").font(.caption).foregroundColor(.gray)
                    }
                    Divider()
                }
                ForEach(replies, \.id) { r in
                    UsersDetails(username: r.replierName, colour: r.replierColour)
                    Text(r.reply).font(.headline)
                    Spacer()
                    Text(r.formatDate()).font(.caption).foregroundColor(.gray)
                    Divider()
                }
            }
            Spacer()
            SendBar(text: $reply, onSend: {
                session.sendReply(content: reply, questionId: question.id)
            })
        }
    }
}
