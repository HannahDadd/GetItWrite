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
    
    var wips: [WIP]
    var action: ([WIP]) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("New Work in Progress (WIP)")
                .font(.title)
                .padding(.bottom, 16)
            QuestionSection(text: "Title:", response: $title)
            NumberSection(text: "Current Word Count:", response: $currentWordCount)
            NumberSection(text: "Target Word Count:", response: $targetWordCount)
            Spacer()
            ErrorText(errorMessage: errorMessage)
            StretchedButton(text: "Add WIP", action: {
                let wip = WIP(id: UUID().hashValue, title: title, count: currentWordCount, goal: targetWordCount)
                var newWips = [wip]
                newWips.append(contentsOf: wips)
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(newWips) {
                    UserDefaults.standard.set(encoded, forKey: UserDefaultNames.wips.rawValue)
                    //BadgeView.incrementBadge(incrementBy: 1, badge: BadgeTitles.projects)
                    action(newWips)
                } else {
                    errorMessage = "Cannot save WIP right now."
                }
            })
        }
        .padding()
    }
}
