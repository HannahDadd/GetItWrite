//
//  QuestionsSeciont.swift
//  Get It Write
//
//  Created by Hannah Dadd on 08/08/2025.
//

import SwiftUI

struct QuestionSection: View {
    var text: String
    @Binding var response: String
    
    var body : some View {
        VStack {
            Text(text).bold().frame(maxWidth: .infinity, alignment: .leading)
            TextEditor(text: $response)
                .frame(height: 100, alignment: .leading)
                .cornerRadius(6.0)
                .border(Color.gray, width: 1)
                .multilineTextAlignment(.leading)
        }
    }
}
