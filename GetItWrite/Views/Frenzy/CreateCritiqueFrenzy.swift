//
//  CreateCritiqueFrenzy.swift
//  Get It Write
//
//  Created by Hannah Billingsley-Dadd on 16/04/2024.
//

import SwiftUI

struct CreateCritiqueFrenzy: View {
    @EnvironmentObject var session: FirebaseSession

    @State private var text: String = ""
    @State private var errorMessage: String = ""
    @State var genres: [String] = []
    @Binding var showMakeCritiqueView: Bool
    
    let isQueries: Bool

    var body: some View {
        VStack {
            Text("Make \(isQueries ? "Query" : "Critique") Frenzy")
                .font(.title)
                .padding(.bottom, 16)
            SelectTagView(chosenTags: $genres, questionLabel: "Select genre:", array: GlobalVariables.genres)
            Text("Add text here:").bold().frame(maxWidth: .infinity, alignment: .leading)
            TextEditor(text: $text)
            ErrorText(errorMessage: errorMessage)
            StretchedButton(text: "Request Critique", action: {
                if CheckInput.isStringGood(text, 1000) {
                    errorMessage = CheckInput.errorStringText(1000)
                } else {
                    session.newCritiqueFrenzy(isQueries: isQueries, text: text, genres: genres) { err in
                        if let err {
                            errorMessage = "Whoops something went wrong! Try again later. Error message: \(err.localizedDescription)"
                        } else {
                            showMakeCritiqueView.toggle()
                        }
                    }
                }
            })
        }.padding()
    }
}
