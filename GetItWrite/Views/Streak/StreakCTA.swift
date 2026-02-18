//
//  StreakCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 23/01/2026.
//

import SwiftUI

struct StreakCTA: View {
    @AppStorage(UserDefaultNames.streakStart.rawValue) private var streakStart: Double = 0
    @AppStorage(UserDefaultNames.streakEnd.rawValue) private var streakEnd: Double = 0
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Spacer()
                Text("\(StreakCTA.getNumberOfDays(streakStart: streakStart, streakEnd: streakEnd))")
                    .font(Font.custom("AbrilFatface-Regular", size: 54))
                    .padding()
                Spacer()
                Text("day\nwriting\nstreak")
                    .font(Font.custom("Bellefair-Regular", size: 26))
                Spacer()
            }
            HStack {
                StreakDay(dayInitial: "M", dayComplete: isDayLit(offset: 0))
                StreakDay(dayInitial: "T", dayComplete: isDayLit(offset: 1))
                StreakDay(dayInitial: "W", dayComplete: isDayLit(offset: 2))
                StreakDay(dayInitial: "T", dayComplete: isDayLit(offset: 3))
                StreakDay(dayInitial: "F", dayComplete: isDayLit(offset: 4))
                StreakDay(dayInitial: "S", dayComplete: isDayLit(offset: 5))
                StreakDay(dayInitial: "S", dayComplete: isDayLit(offset: 6))
            }
        }
    }
    
    static func getNumberOfDays(streakStart: Double, streakEnd: Double) -> Int {
        let startDate = Date.init(timeIntervalSince1970: streakStart)
        let endDate = Date.init(timeIntervalSince1970: streakEnd)
        
        let betweenEndAndNow = Calendar.current.dateComponents([.day], from: endDate, to: Date.now).day ?? 0
        if betweenEndAndNow >= 1 {
            return 0
        }
        
        let streak = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
        if streak == 0 && streakEnd > streakStart {
            return 1
        }
        return streak
    }
    
    func isDayLit(offset: Int) -> Bool {
        let calendar = Calendar.current
        let endDate = calendar.startOfDay(for: Date.init(timeIntervalSince1970: streakEnd))
        let today = calendar.startOfDay(for: Date())
        let startDate = calendar.startOfDay(for: Date.init(timeIntervalSince1970: streakStart + 86000))
        let weekStart = calendar.dateInterval(of: .weekOfYear, for: today)!.start
        
        let day = calendar.date(byAdding: .day, value: offset, to: weekStart)!
        
        let isCompleted = day >= startDate && day <= endDate
        
        return isCompleted
    }
}
