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
    @State private var targetWordCount: Int = 50000
    @State private var errorMessage: String = ""
    
    var wips: [WIP]
    var action: ([WIP]) -> Void
    var text: String = "New Work in Progress (WIP)"
    
    var body: some View {
        VStack(spacing: 15) {
            Text(text)
                .font(Font.custom("AbrilFatface-Regular", size: 34))
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            Spacer()
            Image(systemName: "pencil.and.scribble").resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { size, axis in
                    size * 0.6
                }
            Spacer()
            VStack(alignment: .leading, spacing: 15) {
                QuestionSection(text: "Working Title:", response: $title)
                NumberSection(text: "Target Word Count:", response: $targetWordCount)
            }
            ErrorText(errorMessage: errorMessage)
            StretchedButton(text: "Add WIP", action: {
                let wip = WIP(id: UUID().hashValue, title: title, count: currentWordCount, goal: targetWordCount)
                var newWips = [wip]
                newWips.append(contentsOf: wips)
                if let encoded = try? JSONEncoder().encode(newWips) {
                    UserDefaults.standard.set(encoded, forKey: UserDefaultNames.wips.rawValue)
                    //BadgeView.incrementBadge(incrementBy: 1, badge: BadgeTitles.projects)
                    action(newWips)
                } else {
                    errorMessage = "Cannot save WIP right now."
                }
            })
            EmptyView()
                .frame(maxWidth: .infinity)
        }
        .padding()
    }
}
