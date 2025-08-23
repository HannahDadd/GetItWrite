//
//  CommittmentsCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 08/08/2025.
//

import SwiftUI

struct CommitmentCTA: View {
    @AppStorage(UserDefaultNames.notification.rawValue) private var notif = true
    @State var time = Date()
    @State var weeklyCommitment: WeeklyCommitment = WeeklyCommitment(writingDays: [], time: Date())
    let days = ["Mon", "Tue", "Wed", "Th", "Fri", "Sat", "Sun"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Weekly Writing Schedule")
                .font(.title)
            Toggle("Writing notification", isOn: $notif)
                .tint(.primary)
            if notif {
                VStack(alignment: .leading, spacing: 8) {
                    DatePicker("Time:", selection: $time, displayedComponents: .hourAndMinute)
                        .onChange(of: time) { oldValue, newValue in
                            let newWeeklyCommitment = WeeklyCommitment(writingDays: weeklyCommitment.writingDays, time: time)
                            changeTimeOrDeleteDay(days: newWeeklyCommitment.writingDays, time: newWeeklyCommitment.time)
                            saveToUserDefaults(weeklyCommitment: newWeeklyCommitment)
                        }
                    Text("Days:")
                    HStack {
                        Spacer()
                        ForEach(days, id: \.self) { d in
                            VStack {
                                if weeklyCommitment.writingDays.contains(d) {
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(Color.primary)
                                        .onTapGesture {
                                            let newWeeklyCommitment = WeeklyCommitment(writingDays: weeklyCommitment.writingDays.filter { $0 != d }, time: time)
                                            changeTimeOrDeleteDay(days: newWeeklyCommitment.writingDays, time: newWeeklyCommitment.time)
                                            weeklyCommitment = newWeeklyCommitment
                                            saveToUserDefaults(weeklyCommitment: weeklyCommitment)
                                        }
                                } else {
                                    Image(systemName: "circle")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(Color.primary)
                                        .onTapGesture {
                                            weeklyCommitment.writingDays.append(d)
                                            let newWeeklyCommitment = WeeklyCommitment(writingDays: weeklyCommitment.writingDays, time: time)
                                            scheduleNotif(day: d, date: newWeeklyCommitment.time)
                                            weeklyCommitment = newWeeklyCommitment
                                            saveToUserDefaults(weeklyCommitment: weeklyCommitment)
                                        }
                                }
                                Text(d)
                            }
                        }
                        Spacer()
                    }
                }
                .onAppear {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            if let data = UserDefaults.standard.data(forKey: UserDefaultNames.weeklyCommitment.rawValue) {
                                if let decoded = try? JSONDecoder().decode(WeeklyCommitment.self, from: data) {
                                    weeklyCommitment = decoded
                                    time = weeklyCommitment.time
                                }
                            }
                        } else if error != nil {
                            notif = false
                        }
                    }
                }
            } else {
                Text("")
                    .onAppear {
                        turnOff()
                        saveToUserDefaults(weeklyCommitment: WeeklyCommitment(writingDays: [], time: Date()))
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
    }
    
    private func saveToUserDefaults(weeklyCommitment: WeeklyCommitment) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(weeklyCommitment) {
            UserDefaults.standard.set(encoded, forKey: UserDefaultNames.weeklyCommitment.rawValue)
        }
    }
    
    private func scheduleNotif(day: String, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Let's get writing!"
        content.subtitle = "Open Get it Write and start your writing sprint now!"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.weekday = getDayOfWeekAsNum(day: day)
        dateComponents.hour = Calendar.current.component(.hour, from: date)
        dateComponents.minute = Calendar.current.component(.minute, from: date)
        
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
    
    private func changeTimeOrDeleteDay(days: [String], time: Date) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        days.map { scheduleNotif(day: $0, date: time) }
    }
    
    private func turnOff() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    private func getDayOfWeekAsNum(day: String) -> Int {
        if day == "Mon" {
            return 2
        } else if day == "Tue" {
            return 3
        } else if day == "Wed" {
            return 4
        } else if day == "Th" {
            return 5
        } else if day == "Fri" {
            return 6
        } else if day == "Sat" {
            return 7
        } else {
            return 1
        }
    }
}
