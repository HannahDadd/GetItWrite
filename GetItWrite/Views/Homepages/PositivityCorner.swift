//
//  PositivityCorner.swift
//  Get It Write
//
//  Created by Hannah Dadd on 02/09/2024.
//

import SwiftUI

struct PositivityCorner: View {
    @EnvironmentObject var session: FirebaseSession
    @State var showPopUp = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Positivity Corner").bold()
            HStack {
                Image("positivebg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                VStack {
                    Text("Leave positive feedback on this work and build another writer's confidence.")
                        .font(.subheadline)
                    Spacer()
                    LongArrowButton(title: "Critique") {
                        showPopUp = true
                    }
                }
            }.frame(height: 150)
        }.padding()
        .sheet(isPresented: self.$showPopUp) {
            PositivityPopUp(showPopUp: self.$showPopUp).environmentObject(self.session)
        }
    }
}

struct PositivityPopUp: View {
    @EnvironmentObject var session: FirebaseSession
    
    @State private var result: Result<RequestPositivity, Error>?
    @State private var overallComments = ""
    @State private var errorMessage: String = ""
    @Binding var showPopUp: Bool
    
    var body: some View {
        switch result {
        case .success(let critique):
            VStack {
                ScrollView {
                    Text(critique.text)
                    Divider()
                    ReportAndBlockView(content: critique, contentType: .critiques, toBeBlockedUserId: critique.writerId, imageScale: .large)
                    QuestionSection(text: "Overall Feedback:", response: $overallComments)
                    StretchedButton(text: "Submit Critique", action: {
                        critique.comments[session.userData?.displayName ?? ""] = overallComments
                        session.submitPositvity(p: critique) { error in
                            if let error {
                                errorMessage = error.localizedDescription
                            } else {
                                showPopUp = false
                            }
                        }
                    })
                    ErrorText(errorMessage: errorMessage)
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
