//
//  CreateQuestionView.swift
//  Get It Write
//
//  Created by Hannah Billingsley-Dadd on 16/04/2024.
//

import SwiftUI

struct CreateQuestionView: View {
    @EnvironmentObject var session: FirebaseSession
    
    @State private var question: String = ""
    @State private var errorMessage: String = ""
    
    @Binding var showMakeQuestionView: Bool
    
    var body: some View {
        VStack {
            Text("")
            QuestionSection(text: "Question:", response: $question)
            Spacer()
            ErrorText(errorMessage: errorMessage)
            StretchedButton(text: "Post!", action: {
                if let error =  CheckInput.isStringGood(question, 500) {
                    errorMessage = error
                } else {
                    session.newQuestion(question: question) { err in
                        if let err {
                            errorMessage = "Whoops something went wrong! Try again later. Error message: \(err.localizedDescription)"
                        } else {
                            showMakeQuestionView.toggle()
                        }
                    }
                }
            })
        }.padding()
    }
}
