//
//  NewGoal.swift
//  Get It Write
//
//  Created by Hannah Dadd on 08/08/2025.
//

import SwiftUI

struct NewWIP: View {
    @State private var title: String = ""
    @State private var currentWordCount: Int = 0
    @State private var targetWordCount: Int = 0
    @State private var errorMessage: String = ""
    
    var action: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text("New WIP")
                .font(.title)
                .padding(.bottom, 16)
            QuestionSection(text: "Title:", response: $title)
            NumberSection(text: "Current Word Count:", response: $currentWordCount)
            NumberSection(text: "Target Word Count:", response: $targetWordCount)
            ErrorText(errorMessage: errorMessage)
            StretchedButton(text: "Add WIP", action: {
                let wip = WIP(id: UUID().hashValue, title: title, count: currentWordCount, goal: targetWordCount)
                if let encoded = try? JSONEncoder().encode(wip) {
                        UserDefaults.standard.set(encoded, forKey: "SavedData")
                } else {
                    errorMessage = "Cannot save WIP right now."
                }
            })
        }.padding()
    }
}
