//
//  ForumView.swift
//  Get It Write
//
//  Created by Hannah Billingsley-Dadd on 12/04/2024.
//

import SwiftUI

struct ForumView: View {
    @EnvironmentObject var session: FirebaseSession
    @State var showMakeQuestionView = false
    let questions: [Question]

    var body: some View {
        ZStack {
            List {
                ForEach(questions, id: \.id) { i in
                    QuestionView(question: i)
                }
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
    }
}
