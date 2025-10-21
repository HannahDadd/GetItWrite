//
//  Prompts.swift
//  Get It Write
//
//  Created by Hannah Dadd on 20/10/2025.
//

import SwiftUI

struct PromptsCTA: View {
    let p = GlobalVariables.writingPrompts.randomElement() ?? ""
    
    var body: some View {
        VStack(alignment: .leading) {
            TitleAndSubtitle(
                title: "Writing Prompt of the Day",
                subtitle: "Writers looking for critique partners.")
            PromptCard(question: p)
        }
    }
}
