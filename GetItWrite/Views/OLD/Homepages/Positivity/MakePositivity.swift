//
//  MakePositivity.swift
//  Get It Write
//
//  Created by Hannah Dadd on 05/09/2024.
//

import SwiftUI

struct MakePositivity: View {
    @EnvironmentObject var session: FirebaseSession

    @State private var text: String = ""
    @State private var errorMessage: String = ""
    @Binding var showMakeCritiqueView: Bool
    
    var body: some View {
        VStack {
            Text("Get Good Vibes from the Community")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            VStack(alignment: .leading) {
                Text("Share some of your writing below:").bold().frame(maxWidth: .infinity, alignment: .leading)
                TextEditor(text: $text)
                ErrorText(errorMessage: errorMessage)
                StretchedButton(text: "Request Positive Vibes", action: {
                    if let error =  CheckInput.isStringGood(text, 500) {
                        errorMessage = error
                    } else {
                        session.newPositivity(text: text) { err in
                            if let err {
                                errorMessage = "Whoops something went wrong! Try again later. Error message: \(err.localizedDescription)"
                            } else {
                                showMakeCritiqueView.toggle()
                            }
                        }
                    }
                })
            }
        }.padding()
    }
}
