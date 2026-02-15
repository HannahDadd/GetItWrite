//
//  SprintEndPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 14/02/2026.
//

import SwiftUI

struct SprintEndPage: View {
    @AppStorage(UserDefaultNames.tally.rawValue) private var tally = 0
    
    @AppStorage(UserDefaultNames.quickWords250.rawValue) private var quickWords250 = false
    @AppStorage(UserDefaultNames.quickWords500.rawValue) private var quickWords500 = false
    @AppStorage(UserDefaultNames.quickWords1000.rawValue) private var quickWords1000 = false
    @AppStorage(UserDefaultNames.quickWords2000.rawValue) private var quickWords2000 = false
    @AppStorage(UserDefaultNames.quickWords5000.rawValue) private var quickWords5000 = false
    
    @AppStorage(UserDefaultNames.streakFreak2.rawValue) private var streakFreak2 = false
    @AppStorage(UserDefaultNames.streakFreak7.rawValue) private var streakFreak7 = false
    @AppStorage(UserDefaultNames.streakFreak14.rawValue) private var streakFreak14 = false
    @AppStorage(UserDefaultNames.streakFreak31.rawValue) private var streakFreak31 = false
    @AppStorage(UserDefaultNames.streakFreak100.rawValue) private var streakFreak100 = false
    
    @State var endWordCount: Int = 0
    @Binding var project: WIP?
    @Binding var sprintState: SprintState
    
    let time: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("Sprint Finished!")
                .font(.title)
                .padding(.bottom, 16)
            if let project = project {
                WIPView(w: project)
            }
            Text("Start word count: \(project?.count) words")
                .bold()
            NumberSection(text: "End word count:", response: $endWordCount)
            Spacer()
            StretchedButton(text: "Finish", action: {
                let stat: Stat
                let changeWordCount = (endWordCount - (project?.count ?? 0))
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
                tally = tally + changeWordCount
                
                // Sprint badges
                if changeWordCount > 249 {
                    quickWords250 = true
                }
                if changeWordCount > 499 {
                    quickWords500 = true
                }
                if changeWordCount > 999 {
                    quickWords1000 = true
                }
                if changeWordCount > 1999 {
                    quickWords2000 = true
                }
                if changeWordCount > 4999 {
                    quickWords5000 = true
                }
                
                // Streak badges
                if tally > 1 {
                    streakFreak2 = true
                }
                if changeWordCount > 6 {
                    streakFreak7 = true
                }
                if changeWordCount > 13 {
                    streakFreak14 = true
                }
                if changeWordCount > 30 {
                    streakFreak31 = true
                }
                if changeWordCount > 99 {
                    streakFreak100 = true
                }
                
                sprintState = .end
            })
        }
        .padding()
    }
    
    private func turnDateToMinutes(date: Date) -> Int {
        let hrs = Calendar.current.component(.hour, from: date)
        return (hrs * 60 + Calendar.current.component(.minute, from: date))
    }
}
