//
//  ExpandedQuestionView.swift
//  Get It Write
//
//  Created by Hannah Billingsley-Dadd on 12/04/2024.
//

import SwiftUI

struct ExpandedQuestionView: View {
    let question: Question
    let repliew: [Reply]
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
                ForEach(reply, \.id) { reply in
                    UsersDetails(username: reply.replierName, colour: reply.replierColour)
                    Text(reply.reply).font(.headline)
                    Spacer()
                    HStack {
                        Text(reply.formatDate()).font(.caption).foregroundColor(.gray)
                        Spacer()
                    }
                    Divider()
                }
            }
            Spacer()
            SendBar(text: $reply, onSend: {
                session.sendMessage(content: reply, chatId: chatDetails.0)
            })
        }
    }
}
