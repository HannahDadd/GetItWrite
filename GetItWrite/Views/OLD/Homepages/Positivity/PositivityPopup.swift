//
//  PositivityPopup.swift
//  Get It Write
//
//  Created by Hannah Dadd on 31/01/2025.
//

import SwiftUI

struct PositivityPopUp: View {
    @EnvironmentObject var session: FirebaseSession
    
    @State private var result: Result<RequestPositivity, Error>?
    @State private var overallComments = ""
    @State private var errorMessage: String = ""
    @Binding var showPopUp: Bool
    
    var isAccountPage = false
    
    var body: some View {
        switch result {
        case .success(let critique):
            VStack {
                ScrollView {
                    Text(critique.text)
                    Divider()
                    ReportAndBlockView(content: critique, contentType: .critiques, toBeBlockedUserId: critique.writerId, imageScale: .large)
                    if !isAccountPage {
                        QuestionSection(text: "Overall Feedback:", response: $overallComments)
                        StretchedButton(text: "Submit Critique", action: {
                            if let error =  CheckInput.isStringGood(overallComments, 500) {
                                errorMessage = error
                            } else {
                                critique.comments[session.userData?.displayName ?? ""] = overallComments
                                session.submitPositvity(p: critique) { error in
                                    if let error {
                                        errorMessage = error.localizedDescription
                                    } else {
                                        showPopUp = false
                                    }
                                }
                            }
                        })
                        ErrorText(errorMessage: errorMessage)
                    }
                }
            }.padding()
        case .failure(let error):
            ErrorView(error: error, retryHandler: loadCritiques)
        case nil:
            ProgressView().onAppear(perform: loadCritiques)
        }
    }
    
    private func loadCritiques() {
        session.loadPositivity() {
            result = $0
        }
    }
}
