//
//  Prompts.swift
//  Get It Write
//
//  Created by Hannah Dadd on 20/10/2025.
//

import SwiftUI

struct PromptsCTA: View {
    let prompts = Array(Set(GlobalVariables.writingPrompts)).prefix(5)
    
    var body: some View {
        VStack(alignment: .leading) {
            TitleAndSubtitle(
                title: "Short Story Writing Prompts",
                subtitle: "Writers looking for critique partners.")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(prompts, id: \.self) { p in
                        PromptCard(question: p)
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal)
            }
            .scrollTargetBehavior(.viewAligned)
        }
    }
}
