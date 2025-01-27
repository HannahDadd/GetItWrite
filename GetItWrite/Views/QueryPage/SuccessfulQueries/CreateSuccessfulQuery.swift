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
    @State private var errorMessage: String = ""
    @Binding var showPopUp: Bool
    
    let isQueries: Bool

    var body: some View {
        VStack {
            Text("Make Successful Query")
                .font(.title)
                .padding(.bottom, 16)
            Text("Add text here:").bold().frame(maxWidth: .infinity, alignment: .leading)
            TextEditor(text: $text)
            ErrorText(errorMessage: errorMessage)
            StretchedButton(text: "Post Success Story", action: {
                if let error = CheckInput.isStringGood(text, 1000) {
                    errorMessage = error
                } else {
                    session.newSuccessfulQuery(text: text) { err in
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
