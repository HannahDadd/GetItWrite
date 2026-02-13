//
//  GraphForWip.swift
//  Get It Write
//
//  Created by Hannah Dadd on 23/08/2025.
//

import SwiftUI
import Charts

struct GraphForWriter: View {
    @State private var dayNumbs: [Int] = []
    @State private var stats: [Stat] = []
    @State private var dayValues: [Int: Int] = [:]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                if stats.count < 2 {
                    Text("Not enough statistics to show yet! Keep writing!")
                } else {
                    Text("You've written a total of \(getWordsWritten()) words across \(stats.count) sprints!")
                        .bold()
                    
                    Chart {
                        ForEach(stats) { stat in
                            BarMark(x: .value("Date", stat.date.formatted(date: .long, time: .shortened)),
                                    y: .value("Words written", stat.wordsWritten))
                            .foregroundStyle(Color.primary)
                        }
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .chartXAxisLabel("Date")
                    .chartYAxisLabel("Words Written")
                    
                    Chart {
                        ForEach(stats) { stat in
                            LineMark(x: .value("Date", stat.date.formatted(date: .long, time: .shortened)),
                                     y: .value("Words written", stat.wordsWritten))
                            .foregroundStyle(Color.primary)
                        }
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .chartXAxisLabel("Date")
                    .chartYAxisLabel("Words Written")
                    
//                    VStack {
//                        Text("You're favourite day to write is \(getFavouriteDayOfWeek(scores: dayValues))")
//                            .bold()
//                        Chart {
//                            ForEach($dayNumbs, id: \.hashValue) { day in
//                                BarMark(x: .value("Date", getDayOfWeek(day: day.wrappedValue)),
//                                        y: .value("Frequency", dayValues[day.wrappedValue] ?? 0))
//                                .foregroundStyle(Color.primary)
//                            }
//                        }
//                        .aspectRatio(1, contentMode: .fit)
//                        .chartXAxisLabel("Day")
//                    }
                }
            }
            .onAppear {
                if let data = UserDefaults.standard.data(forKey: UserDefaultNames.stats.rawValue) {
                    if let decoded = try? JSONDecoder().decode([Stat].self, from: data) {
                        stats = decoded
//                        dayValues = getDaysWriting()
//                        dayNumbs = dayValues.map { $0.key }
                    }
                }
            }
        }
    }
    
    private func getWordsWritten() -> Int {
        return stats.compactMap { $0.wordsWritten }.reduce(0, +)
    }
    
    private func getDaysWriting() -> [Int : Int] {
        let daysOfWeek = stats
            .compactMap { $0.date }
            .map { Calendar.current.component(.day, from: $0) }
        var countDict: [Int:Int] = [:]
        daysOfWeek.map {
            let count = countDict[$0, default: 1]
            countDict[$0] = count + 1
        }
        return countDict
    }
    
    private func getFavouriteDayOfWeek(scores: [Int : Int]) -> String {
        let max = scores.max { $0.value < $1.value }
        return getDayOfWeek(day: max?.key ?? 0)
    }
    
    private func getDayOfWeek(day: Int) -> String {
        if day == 1 {
            return "Mon"
        } else if day == 3 {
            return "Tue"
        } else if day == 4 {
            return "Wed"
        } else if day == 5 {
            return "Th"
        } else if day == 6 {
            return "Fri"
        } else if day == 7 {
            return "Sat"
        } else {
            return "Sun"
        }
    }
}
