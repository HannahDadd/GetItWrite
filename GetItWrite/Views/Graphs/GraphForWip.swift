//
//  GraphForWip.swift
//  Get It Write
//
//  Created by Hannah Dadd on 23/08/2025.
//

import SwiftUI
import Charts

struct GraphForWIP: View {
    @State private var stats: [Stat] = []
    var wip: WIP
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Your statistics for \(wip.title)")
                    .font(.title)
                    .padding(.bottom, 16)
                WIPView(w: wip)
                if stats.count > 2 {
                    Text("Not enough statistics to show for this project yet! Keep writing!")
                } else {
                    
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
                }
            }
            .padding()
            .onAppear {
                if let data = UserDefaults.standard.data(forKey: UserDefaultNames.stats.rawValue) {
                    if let decoded = try? JSONDecoder().decode([Stat].self, from: data) {
                        stats = decoded.filter { $0.wipId == wip.id }
                    }
                }
            }
        }
    }
}
