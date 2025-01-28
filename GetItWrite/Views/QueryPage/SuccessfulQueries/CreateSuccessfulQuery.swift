//
//  CreateSuccessfulQuery.swift
//  Get It Write
//
//  Created by Hannah Dadd on 27/01/2025.
//

import SwiftUI
import UserNotifications

struct CreateSuccessfulQuery: View {
    @EnvironmentObject var session: FirebaseSession

    @State private var text: String = ""
    @State private var notes: String = ""
    @State private var errorMessage: String = ""
    @Binding var showPopUp: Bool

    var body: some View {
        VStack {
            Text("Make Successful Query")
                .font(.title)
                .padding(.bottom, 16)
            Text("Add text here:").bold().frame(maxWidth: .infinity, alignment: .leading)
            TextEditor(text: $text)
            TitleAndSubtitle(title: "Author's notes", subtitle: "Tell other writers about your query journey, the success this query got and any other notes you'd like to add. (optional)")
            TextEditor(text: $notes)
            ErrorText(errorMessage: errorMessage)
            StretchedButton(text: "Post Success Story", action: {
                if let error = CheckInput.isStringGood(text, 1000) {
                    errorMessage = error
                } else if let profanity = CheckInput.verify(input: notes) {
                    errorMessage = "Notes contains \(profanity) which is not allowed."
                } else {
                    session.newSuccessfulQuery(text: text, notes: notes) { err in
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
