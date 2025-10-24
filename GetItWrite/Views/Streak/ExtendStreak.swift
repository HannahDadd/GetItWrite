//
//  ExtendStreak.swift
//  Get It Write
//
//  Created by Hannah Dadd on 22/10/2025.
//

import SwiftUI

struct ExtendStreak: View {
    @AppStorage(UserDefaultNames.streak.rawValue) private var streakEndDate = Date()
    @State var project: WIP? = nil
    @State var endWordCount: Int = 0
    @State var editing = false
    @State var selectWIP = false
    var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("Great job today!")
                .font(.title)
                .padding(.bottom, 16)
            Toggle("Editing", isOn: $editing)
                .tint(.primary)
            if !editing {
                if let project = project {
                    Text("Selected project")
                        .font(.headline)
                    WIPView(w: project)
                    Button("Change WIP") {
                        selectWIP.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.primary)
                } else {
                    Button("Select the project you worked on.") {
                        selectWIP.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.primary)
                }
                NumberSection(text: "Words written today:", response: $endWordCount)
            }
            Spacer()
            StretchedButton(text: "Extend streak!", action: {
                let stat: Stat
                
                if !editing {
                    // update project word count
                    if let wip = project {
                        if let data = UserDefaults.standard.data(forKey: UserDefaultNames.wips.rawValue) {
                            if let decoded = try? JSONDecoder().decode([WIP].self, from: data) {
                                var newWips = decoded.filter { $0.id != wip.id }
                                let newWordCount = endWordCount + wip.count
                                let newWip = WIP(id: wip.id, title: wip.title, count: newWordCount, goal: wip.goal)
                                project = newWip
                                newWips.append(newWip)
                                let encoder = JSONEncoder()
                                if let encoded = try? encoder.encode(newWips) {
                                    UserDefaults.standard.set(encoded, forKey: UserDefaultNames.wips.rawValue)
                                }
                            }
                        }
                        stat = Stat(id: UUID().hashValue, wordsWritten: endWordCount, date: Date(), wipId: wip.id, minutes: nil)
                    } else {
                        stat = Stat(id: UUID().hashValue, wordsWritten: endWordCount, date: Date(), wipId: nil, minutes: nil)
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
                    
                    // increment badge
                    BadgeView.incrementBadge(incrementBy: endWordCount, badge: BadgeTitles.wordsWritten)
                }
                streakEndDate = Date()
                
                action()
            })
        }
        .padding()
        .sheet(isPresented: $selectWIP) {
            SelectWip(action: { wip in
                project = wip
                selectWIP = false
            })
        }
    }
}
