//
//  CommittmentsCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 08/08/2025.
//

import SwiftUI

struct CommitmentCTA: View {
    @State var weeklyCommitment: WeeklyCommitment = WeeklyCommitment(writingDays: [], time: Date())
    let days = ["Mon", "Tue", "Wed", "Th", "Fri", "Sat", "Sun"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Your Weekly Writing Schedule")
                .multilineTextAlignment(.leading)
                .textCase(.uppercase)
            DatePicker("Time of writing notification:", selection: $weeklyCommitment.time, displayedComponents: .hourAndMinute)
            HStack {
                ForEach(days, id: \.self) { d in
                    VStack {
                        if weeklyCommitment.writingDays.contains(d) {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color.primary)
                                .onTapGesture {
                                    weeklyCommitment.writingDays = weeklyCommitment.writingDays.filter { $0 != d }
                                }
                        } else {
                            Image(systemName: "circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color.primary)
                                .onTapGesture {
                                    weeklyCommitment.writingDays.append(d)
                                }
                        }
                        Text(d)
                    }
                }
            }
        }
        .onAppear {
            if let data = UserDefaults.standard.data(forKey: UserDefaultNames.weeklyCommitment.rawValue) {
                if let decoded = try? JSONDecoder().decode(WeeklyCommitment.self, from: data) {
                    weeklyCommitment = decoded
                }
            }
        }
        .padding()
    }
}
