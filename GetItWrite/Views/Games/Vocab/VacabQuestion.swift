//
//  VacabQuestion.swift
//  Get It Write
//
//  Created by Hannah Dadd on 21/10/2025.
//

import SwiftUI

struct VocabQuestion: View {
    @State private var showingPopover = false
    
    let word: String
    let definition: String
    let options: [String]
    
    var nextCard: () -> Void
    
    var body: some View {
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
                .popover(isPresented: $showingPopover) {
                    Text("That's not quite right!")
                        .font(.headline)
                        .padding()
                }
                .onTapGesture {
                    if o == definition {
                        nextCard()
                    } else {
                        showingPopover = true
                    }
                }
            }
            
        }
    }
}
