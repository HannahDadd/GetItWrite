//
//  QuestionView.swift
//  Get It Write
//
//  Created by Hannah Billingsley-Dadd on 12/04/2024.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var session: FirebaseSession
    let question: Question
    
    var body: some View {
        NavigationLink(destination: ExpandedQuestionView(question: question)) {
            VStack(alignment: .leading, spacing: 12) {
                Text(question.question).font(.headline)
            }.navigationTitle("Questions")
        }
    }
}
