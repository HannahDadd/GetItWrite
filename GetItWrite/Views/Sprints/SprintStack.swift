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
    
    var body: some View {
        VStack {
            switch sprintState {
            case .start:
                StartSprintPage(duration: "", selectWIP: $selectWIP, project: $project, sprintState: $sprintState, startWordCount: $startWordCount)
            case .wait:
                SprintLoadingPage(endState: {
                    sprintState = .sprint
                })
            case .sprint:
                SprintView(timeRemaining: turnDateToMinutes(date: time), endState: {
                    sprintState = .end
                })
            case .end:
                VStack(alignment: .leading, spacing: 30) {
                    Text("Sprint Finished!")
                        .font(.title)
                        .padding(.bottom, 16)
                    if let project = project {
                        Text("Selected project:")
                            .font(.headline)
                        WIPView(w: project)
                    }
                    Text("Start word count: \(startWordCount) words")
                        .bold()
                    NumberSection(text: "End word count:", response: $endWordCount)
                    Spacer()
                    StretchedButton(text: "Finish", action: {
                        let stat: Stat
                        let changeWordCount = (endWordCount - startWordCount)
                        let minutes = turnDateToMinutes(date: time)
                        
                        // update project word count
                        if let wip = project {
                            if let data = UserDefaults.standard.data(forKey: UserDefaultNames.wips.rawValue) {
                                if let decoded = try? JSONDecoder().decode([WIP].self, from: data) {
                                    var newWips = decoded.filter { $0.id != wip.id }
                                    let newWordCount = endWordCount
                                    let newWip = WIP(id: wip.id, title: wip.title, count: newWordCount, goal: wip.goal)
                                    project = newWip
                                    newWips.append(newWip)
                                    let encoder = JSONEncoder()
                                    if let encoded = try? encoder.encode(newWips) {
                                        UserDefaults.standard.set(encoded, forKey: UserDefaultNames.wips.rawValue)
                                    }
                                }
                            }
                            stat = Stat(id: UUID().hashValue, wordsWritten: changeWordCount, date: Date(), wipId: wip.id, minutes: minutes)
                        } else {
                            stat = Stat(id: UUID().hashValue, wordsWritten: changeWordCount, date: Date(), wipId: nil, minutes: minutes)
                        }
                        
                        // add statistics
                        var statsToAppend: [Stat] = []
                        let encoder = JSONEncoder()
                        if let data = UserDefaults.standard.data(forKey: UserDefaultNames.stats.rawValue) {
                            if let decoded = try? JSONDecoder().decode([Stat].self, from: data) {
                                statsToAppend.append(contentsOf: decoded)
                            }
                        }
                        statsToAppend.append(stat)
                        if let encoded = try? encoder.encode(statsToAppend) {
                            UserDefaults.standard.set(encoded, forKey: UserDefaultNames.stats.rawValue)
                        }
                        
                        // Increase streak
                        streak = streak + endWordCount
                        
                        sprintState = .showResults
                    })
                }
                .padding()
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
    }
    
    private func turnDateToMinutes(date: Date) -> Int {
        let hrs = Calendar.current.component(.hour, from: date)
        return (hrs * 60 + Calendar.current.component(.minute, from: date))
    }
}

enum SprintState {
    case start
    case wait
    case sprint
    case end
    case showResults
}
