//
//  StreakCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 23/01/2026.
//

import SwiftUI
import GetItWriteShared

struct StreakCTA: View {
    @AppStorage(UserDefaultNames.streakCount.rawValue) private var streakCount = 0
    @AppStorage(UserDefaultNames.lastActivityDate.rawValue) private var lastActivityTimestamp: Double = 0
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Spacer()
                Text("\(streakCount)")
                    .font(Font.custom("AbrilFatface-Regular", size: 54))
                    .padding()
                Spacer()
                Text("day\nwriting\nstreak")
                    .font(Font.custom("Bellefair-Regular", size: 26))
                Spacer()
            }
            HStack {
                StreakDay(dayInitial: "M", dayComplete: GetItWriteShared.isDayLit(offset: 0, streakCount: streakCount, lastActivityTimestamp: lastActivityTimestamp))
                StreakDay(dayInitial: "T", dayComplete: GetItWriteShared.isDayLit(offset: 1, streakCount: streakCount, lastActivityTimestamp: lastActivityTimestamp))
                StreakDay(dayInitial: "W", dayComplete: GetItWriteShared.isDayLit(offset: 2, streakCount: streakCount, lastActivityTimestamp: lastActivityTimestamp))
                StreakDay(dayInitial: "T", dayComplete: GetItWriteShared.isDayLit(offset: 3, streakCount: streakCount, lastActivityTimestamp: lastActivityTimestamp))
                StreakDay(dayInitial: "F", dayComplete: GetItWriteShared.isDayLit(offset: 4, streakCount: streakCount, lastActivityTimestamp: lastActivityTimestamp))
                StreakDay(dayInitial: "S", dayComplete: GetItWriteShared.isDayLit(offset: 5, streakCount: streakCount, lastActivityTimestamp: lastActivityTimestamp))
                StreakDay(dayInitial: "S", dayComplete: GetItWriteShared.isDayLit(offset: 6, streakCount: streakCount, lastActivityTimestamp: lastActivityTimestamp))
            }
        }
    }
}
