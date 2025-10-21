//
//  VacabQuestion.swift
//  Get It Write
//
//  Created by Hannah Dadd on 21/10/2025.
//

import SwiftUI

struct VocabQuestion: View {
    @State private var showError = false
    @State private var showCorrect = false
    
    let word: String
    let definition: String
    let options: [String]
    
    var nextCard: () -> Void
    
    var body: some View {
        ZStack {
            if showError {
                popUp(text: "Not quite!", onButtonPress: { showError.toggle() })
            }
            if showCorrect {
                popUp(text: "You got it!", onButtonPress: nextCard)
            }
            VStack {
                Text("What does **\(word)** mean?")
                ForEach(options, id: \.self) { o in
                    VStack(alignment: .leading) {
                        Text(o)
                            .font(.headline)
                            .foregroundColor(Color.onCardBackground)
                            .bold()
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .background(Color.cardBackground)
                    .cornerRadius(8)
                    .onTapGesture {
                        if o == definition {
                            showCorrect.toggle()
                        } else {
                            showError.toggle()
                        }
                    }
                }
            }
        }
    }
    
    func popUp(text: String, onButtonPress: @escaping () -> Void) -> some View {
        VStack(alignment: .leading) {
            Text(text)
                .font(.headline)
                .foregroundColor(Color.onCardBackground)
                .bold()
                .multilineTextAlignment(.leading)
            StretchedButton(text: "Try Again", action: onButtonPress)
        }
        .padding()
        .frame(height: 100)
        .frame(maxWidth: .infinity)
        .background(Color.cardBackground)
        .cornerRadius(8)
    }
}
