//
//  CommittmentsCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 08/08/2025.
//

import SwiftUI

struct CommitmentCTA: View {
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
                        scheduleNotif()
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
                    scheduleNotif()
                    notif = true
                    showSetSheet = false
                })
            }.padding()
        }
    }
    
    private func scheduleNotif() {
        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.current.component(.hour, from: time)
        dateComponents.minute = Calendar.current.component(.hour, from: time)
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

struct PopupPromo: View {
    var title: String
    var subtitle: String
    var action: () -> Void
    
    var body: some View {
        ZStack(alignment: .leading) {
            DrawingPathsPopupPromo()
                .background(Color.primary)
            VStack(alignment: .leading) {
                Text(title)
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                    .foregroundColor(Color.onSecondary)
                Spacer()
                Text(subtitle)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .font(.subheadline)
                    .foregroundColor(Color.onSecondary)
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .cornerRadius(8)
        .onTapGesture { action() }
        .shadow(radius: 5)
    }
}

struct DrawingPathsPopupPromo: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 180, y: 0))
            path.addCurve(to: CGPoint(x: 150, y: 140), control1: CGPoint(x: 100, y: 75), control2: CGPoint(x: 110, y: 80))
            path.addLine(to: CGPoint(x: 0, y: 100))
        }
        .fill(Color.secondary)
        .edgesIgnoringSafeArea(.top)
    }
}
