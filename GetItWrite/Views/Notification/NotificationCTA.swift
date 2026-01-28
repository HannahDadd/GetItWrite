//
//  CommittmentsCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 08/08/2025.
//

import SwiftUI

struct NotificationCTA: View {
    @AppStorage(UserDefaultNames.notification.rawValue) private var notif = false
    @State var showSetSheet = false
    @State var showEditSheet = false
    @State var time = Date()
    
    var body: some View {
        VStack {
            if notif {
                VStack {
                    PopupPromo(title: "You have a daily notification set!", subtitle: "Tap to edit", action: {
                        showEditSheet = true
                    })
                }
            } else {
                VStack {
                    PopupPromo(title: "Lets get that book written", subtitle: "Set a daily notification", action: {
                        showSetSheet = true
                    })
                }
            }
        }
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if error != nil {
                    notif = false
                }
            }
        }
        .sheet(isPresented: $showEditSheet) {
            VStack(alignment: .leading, spacing: 48) {
                Text("Edit Daily Notification").font(.title)
                VStack(alignment: .leading) {
                    Text("Edit time of daily notification:")
                        .multilineTextAlignment(.leading)
                    DatePicker("Time:", selection: $time, displayedComponents: .hourAndMinute)
                }
                Spacer()
                VStack {
                    StretchedButton(text: "Schedule", action: {
                        turnOff()
                        NotificationCTA.scheduleNotif(time: time)
                        notif = true
                        showEditSheet = false
                    })
                    StretchedButton(text: "Cancel Notification", action: {
                        turnOff()
                        notif = false
                        showEditSheet = false
                    }, isGrey: true)
                }
            }.padding()
        }
        .sheet(isPresented: $showSetSheet) {
            VStack(alignment: .leading, spacing: 48) {
                Text("Schedule Daily Notification").font(.title)
                VStack(alignment: .leading) {
                    Text("What time do you want the daily notification?")
                        .multilineTextAlignment(.leading)
                    DatePicker("Time:", selection: $time, displayedComponents: .hourAndMinute)
                }
                Spacer()
                StretchedButton(text: "Schedule", action: {
                    turnOff()
                    NotificationCTA.scheduleNotif(time: time)
                    notif = true
                    showSetSheet = false
                })
            }.padding()
        }
    }
    
    static func scheduleNotif(time: Date) {
        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.current.component(.hour, from: time)
        dateComponents.minute = Calendar.current.component(.minute, from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = "Let's get writing!"
        content.subtitle = "Open Get it Write and start your writing sprint now!"
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    private func turnOff() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
