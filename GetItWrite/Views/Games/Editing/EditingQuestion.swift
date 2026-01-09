//
//  ReplaceWordVide.swift
//  Get It Write
//
//  Created by Hannah Dadd on 21/10/2025.
//

import SwiftUI

struct EditingQuestion: View {
    @State var response: String = ""
    let sentence = GlobalVariables.badSentences.randomElement()!
    var back: () -> Void
    
    var body: some View {
        VStack {
            Text("Rewrite the sentence below to practice your editing skills.")
            Text(sentence).bold()
            TextEditor(text: $response)
                .frame(height: 100, alignment: .leading)
                .cornerRadius(6.0)
                .border(Color.gray, width: 1)
                .multilineTextAlignment(.leading)
            StretchedButton(text: "Done", action: back)
        }
    }
}
