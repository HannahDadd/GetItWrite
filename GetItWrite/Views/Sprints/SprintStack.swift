//
//  SprintStack.swift
//  Get It Write
//
//  Created by Hannah Dadd on 08/08/2025.
//

import SwiftUI

struct SprintStack: View {
    @State var sprintState: SprintState = .start
    @State var project: WIP? = nil
    @State var badgesEarnt: [Badge] = []
    @State var wordsWritten: Int = 0
    
    let time: Int
    let action: () -> Void
    var waitingTime: Int?
    
    var body: some View {
        VStack {
            switch sprintState {
            case .start:
                StartSprintPage(duration: "", project: $project, sprintState: $sprintState)
            case .sprint:
                SprintView(endState: {
                    sprintState = .end
                }, time: time)
            case .end:
                SprintEndPage(sprintState: $sprintState, badgesEarnt: $badgesEarnt, project: $project, wordsWritten: $wordsWritten, minutes: time)
            case .showResults:
                PostSprintAcheivementsPage(project: project, wordsWritten: wordsWritten, badgesEarnt: badgesEarnt, action: action)
            }
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            if let data = UserDefaults.standard.data(forKey: UserDefaultNames.wips.rawValue) {
                if let decoded = try? JSONDecoder().decode([WIP].self, from: data) {
                    if !decoded.isEmpty {
                        project = decoded.first
                        wordsWritten = project?.count ?? 0
                    }
                }
            }
        }
    }
}

enum SprintState {
    case start
    case sprint
    case end
    case showResults
}
