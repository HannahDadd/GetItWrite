//
//  CreateBulletinView.swift
//  Get It Write
//
//  Created by Hannah Dadd on 28/01/2025.
//

import SwiftUI
import UserNotifications

struct CreateBulletinView: View {
    @EnvironmentObject var session: FirebaseSession

    @State private var text: String = ""
    @State private var errorMessage: String = ""
    @Binding var showPopUp: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text("Post on the noticeboard")
                .font(.title)
                .padding(.bottom, 16)
            QuestionSection(text: "Post:", response: $text)
            Spacer()
            ErrorText(errorMessage: errorMessage)
            StretchedButton(text: "Post Notice", action: {
                if let error = CheckInput.isStringGood(text, 1000) {
                    errorMessage = error
                } else {
                    session.newBulletin(text: text) { err in
                        if let err {
                            errorMessage = "Whoops something went wrong! Try again later. Error message: \(err.localizedDescription)"
                        } else {
                            showPopUp.toggle()
                        }
                    }
                }
            })
        }.padding()
    }
}
