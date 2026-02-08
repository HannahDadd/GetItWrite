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
                Text("\(getNumberOfDays(streak: streakStart))")
                    .font(Font.custom("AbrilFatface-Regular", size: 44))
                    .padding()
                    .foregroundColor(.onPrimary)
                    .background(.primary)
                    .clipShape(Capsule())
                Spacer()
                Text("day\nstreak")
                    .font(Font.custom("Bellefair-Regular", size: 30))
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
    
    func getNumberOfDays(streak: Double) -> Int {
        let date = Date.init(timeIntervalSince1970: streak)
        return Calendar.current.dateComponents([.day], from: date, to: Date.now).day ?? 0
    }
    
    func isDayLit(offset: Int) -> Bool {
        let streakStartDate = Date.init(timeIntervalSince1970: streakStart)
        let streakEndDate = Date.init(timeIntervalSince1970: streakEnd)
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let startDate = calendar.startOfDay(for: streakStartDate)
        let weekStart = calendar.dateInterval(of: .weekOfYear, for: today)!.start
        
        let day = calendar.date(byAdding: .day, value: offset, to: weekStart)!
        let weekdayIndex = calendar.component(.weekday, from: day) - 1
        
        let isCompleted = day >= startDate && day <= today
        
        return isCompleted
        
    }
}
