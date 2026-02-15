//
//  SprintStack.swift
//  Get It Write
//
//  Created by Hannah Dadd on 08/08/2025.
//

import SwiftUI

struct SprintStack: View {
    @AppStorage(UserDefaultNames.tally.rawValue) private var streak = 0
    @State var selectWIP = false
    @State var project: WIP? = nil
    @State var sprintState: SprintState = .start
    @State var startWordCount: Int = 0
    @State var endWordCount: Int = 0
    @State var time = Date.init(timeIntervalSince1970: -2400)
    
    let action: () -> Void
    var waitingTime: Int?
    
    var body: some View {
        VStack {
            switch sprintState {
            case .start:
                StartSprintPage(duration: "", selectWIP: $selectWIP, project: $project, sprintState: $sprintState, startWordCount: $startWordCount)
            case .sprint:
                SprintView(endState: {
                    sprintState = .end
                }, time: 60)
            case .end:
            case .showResults:
                VStack(alignment: .leading, spacing: 30) {
                    Text("You're one step closer to hitting that writing goal!")
                        .font(.title)
                        .padding(.bottom, 16)
                    Text("You wrote \(endWordCount - startWordCount) words in \(turnDateToMinutes(date: time)) minutes.")
                    if let project = project {
                        Text("Selected project:")
                            .font(.headline)
                        WIPView(w: project)
                        GraphForWIP(wip: project)
                    }
                    StretchedButton(text: "Back To Home Page", action: {
                        action()
                    })
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            if let data = UserDefaults.standard.data(forKey: UserDefaultNames.wips.rawValue) {
                if let decoded = try? JSONDecoder().decode([WIP].self, from: data) {
                    if !decoded.isEmpty {
                        project = decoded.first
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
    case badgesWon
}
