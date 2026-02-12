//
//  OnboardingPageTwo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 26/01/2026.
//

import SwiftUI

struct OnboardingPageTwo: View {
    @AppStorage(UserDefaultNames.notification.rawValue) private var notif = false
    @State var time = Date()
    
    let nextPage: () -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Get daily writing reminders")
                .font(Font.custom("AbrilFatface-Regular", size: 34))
                .padding(.bottom, 16)
                .multilineTextAlignment(.center)
            Spacer()
            Image(systemName: "bell.fill")
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { size, axis in
                    size * 0.6
                }
            Spacer()
            DatePicker("Time of notification:", selection: $time, displayedComponents: .hourAndMinute)
            StretchedButton(text: "Schedule", action: {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if error != nil {
                        notif = false
                    }
                }
                NotificationCTA.scheduleNotif(time: time)
                notif = true
                nextPage()
            })
            Button("Skip", action: {
                nextPage()
            })
            .buttonStyle(.plain)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
