//
//  SprintEndPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 14/02/2026.
//

import SwiftUI

struct SprintEndPage: View {
    @AppStorage(UserDefaultNames.tally.rawValue) private var tally = 0
    @AppStorage(UserDefaultNames.streakStart.rawValue) private var streakStart: Double = 0
    @AppStorage(UserDefaultNames.streakEnd.rawValue) private var streakEnd: Double = 0
    
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
    
    @AppStorage(UserDefaultNames.wordNerd200.rawValue) private var wordNerd200 = false
    @AppStorage(UserDefaultNames.wordNerd500.rawValue) private var wordNerd500 = false
    @AppStorage(UserDefaultNames.wordNerd1000.rawValue) private var wordNerd1000 = false
    @AppStorage(UserDefaultNames.wordNerd10000.rawValue) private var wordNerd10000 = false
    @AppStorage(UserDefaultNames.wordNerd20000.rawValue) private var wordNerd20000 = false
    @AppStorage(UserDefaultNames.wordNerd50000.rawValue) private var wordNerd50000 = false
    
    @AppStorage(UserDefaultNames.bookGoal.rawValue) private var bookGoal = false
    
    @AppStorage(UserDefaultNames.hourSprint.rawValue) private var hourSprint = false
    @AppStorage(UserDefaultNames.fortySprint.rawValue) private var fortySprint = false
    @AppStorage(UserDefaultNames.twentySprint.rawValue) private var twentySprint = false
    
    @Binding var sprintState: SprintState
    @Binding var badgesEarnt: [Badge]
    @Binding var project: WIP?
    @Binding var wordsWritten: Int
    
    @State var endWordCount: Int = 0
    
    let minutes: Int
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Sprint Finished!")
                .font(Font.custom("AbrilFatface-Regular", size: 34))
                .padding(.bottom, 16)
            if let project = project {
                WIPView(w: project)
            }
            Text("Start word count: \(project?.count ?? 0) words")
                .font(Font.custom("Bellefair-Regular", size: 18))
            NumberSection(text: "Type your end word count:", response: $endWordCount)
            Text("You wrote \(endWordCount - (project?.count ?? 0)) words")
                .font(Font.custom("Bellefair-Regular", size: 18))
            Spacer()
            StretchedButton(text: "Finish", action: {
                let stat: Stat
                let changeWordCount = (endWordCount - (project?.count ?? 0))
                wordsWritten = changeWordCount
                streakEnd = Date.now.timeIntervalSince1970
                
                // if its the first day of streak, increase start
                let endDate = Date.init(timeIntervalSince1970: streakEnd)
                let betweenEndAndNow = Calendar.current.dateComponents([.day], from: endDate, to: Date.now).day ?? 0
                if betweenEndAndNow >= 1 {
                    streakStart = Date.now.timeIntervalSince1970 - 86000
                }
                
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
                            
                            if newWip.count >= newWip.goal {
                                bookGoal = true
                                badgesEarnt.append(Badge.bookGoal)
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
                if minutes == 20 && !twentySprint {
                    twentySprint = true
                    badgesEarnt.append(Badge.twentySprint)
                } else if minutes == 40 && !fortySprint {
                    fortySprint = true
                    badgesEarnt.append(Badge.fortySprint)
                } else if minutes == 60 && !hourSprint {
                    hourSprint = true
                    badgesEarnt.append(Badge.hourSprint)
                }
                
                // Sprint badges
                if changeWordCount > 249 && !quickWords250 {
                    quickWords250 = true
                    badgesEarnt.append(Badge.quickWords250)
                }
                if changeWordCount > 499 && !quickWords500 {
                    quickWords500 = true
                    badgesEarnt.append(Badge.quickWords500)
                }
                if changeWordCount > 999 && !quickWords1000 {
                    quickWords1000 = true
                    badgesEarnt.append(Badge.quickWords1000)
                }
                if changeWordCount > 1999 && !quickWords2000 {
                    quickWords2000 = true
                    badgesEarnt.append(Badge.quickWords2000)
                }
                if changeWordCount > 4999 && !quickWords5000 {
                    quickWords5000 = true
                    badgesEarnt.append(Badge.quickWords5000)
                }
                
                // Streak badges
                let streak = StreakCTA.getNumberOfDays(streakStart: streakStart, streakEnd: streakEnd)
                if streak > 1 && !streakFreak2 {
                    streakFreak2 = true
                    badgesEarnt.append(Badge.streakFreak2)
                }
                if streak > 6 && !streakFreak7 {
                    streakFreak7 = true
                    badgesEarnt.append(Badge.streakFreak7)
                }
                if streak > 13 && !streakFreak14 {
                    streakFreak14 = true
                    badgesEarnt.append(Badge.streakFreak14)
                }
                if streak > 30 && !streakFreak31 {
                    streakFreak31 = true
                    badgesEarnt.append(Badge.streakFreak31)
                }
                if streak > 99 && !streakFreak100 {
                    streakFreak100 = true
                    badgesEarnt.append(Badge.streakFreak100)
                }
                
                // Word badges
                if tally > 199 && !wordNerd200 {
                    wordNerd200 = true
                    badgesEarnt.append(Badge.wordNerd200)
                }
                if tally > 499 && !wordNerd500 {
                    wordNerd500 = true
                    badgesEarnt.append(Badge.wordNerd500)
                }
                if tally > 999 && !wordNerd1000 {
                    wordNerd1000 = true
                    badgesEarnt.append(Badge.wordNerd1000)
                }
                if tally > 9999 && !wordNerd10000 {
                    wordNerd10000 = true
                    badgesEarnt.append(Badge.wordNerd10000)
                }
                if tally > 19999 && !wordNerd20000 {
                    wordNerd20000 = true
                    badgesEarnt.append(Badge.wordNerd20000)
                }
                if tally > 49999 && !wordNerd50000 {
                    wordNerd50000 = true
                    badgesEarnt.append(Badge.wordNerd50000)
                }
                
                sprintState = .showResults
            })
        }
        .padding()
    }
    
    private func turnDateToMinutes(date: Date) -> Int {
        let hrs = Calendar.current.component(.hour, from: date)
        return (hrs * 60 + Calendar.current.component(.minute, from: date))
    }
}
