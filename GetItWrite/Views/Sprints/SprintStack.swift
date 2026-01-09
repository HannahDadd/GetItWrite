//
//  SprintStack.swift
//  Get It Write
//
//  Created by Hannah Dadd on 08/08/2025.
//

import SwiftUI

struct SprintStack: View {
    @State var sprintState: SprintState = .start
    @State var startWordCount: String = ""
    @State var time: String = ""
    
    var body: some View {
        switch sprintState {
        case .start:
            VStack {
                QuestionSection(text: "Start Word Count", response: $startWordCount)
                QuestionSection(text: "Time", response: $startWordCount)
                Spacer()
                StretchedButton(text: "Start", action: {
                    sprintState = .sprint
                })
                Spacer()
            }
            .padding()
            .background(Color.purple)
        case .sprint:
            Sprint(endState: {
                sprintState = .end
            })
        case .end:
            VStack {
                Spacer()
                QuestionSection(text: "Times up! End Word Count", response: $startWordCount)
                Spacer()
                StretchedButton(text: "Finish", action: {
                })
                Spacer()
            }.background(Color.purple)
        }
    }
}

enum SprintState {
    case start
    case sprint
    case end
}
