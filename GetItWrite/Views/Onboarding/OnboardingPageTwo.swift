//
//  OnboardingPageTwo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 26/01/2026.
//

import SwiftUI

struct OnboardingPageTwo: View {
    @AppStorage(UserDefaultNames.notification.rawValue) private var notif = false
    @State var nextPage = false
    @State var time = Date()
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Grab a cuppa, stretch, & get hyped. The sprint starts in")
                .font(Font.custom("AbrilFatface-Regular", size: 34))
                .foregroundColor(Color.white)
                .padding(.bottom, 16)
            Image(systemName: "bell.fill")
                .foregroundColor(Color.white)
            VStack(alignment: .leading) {
                Text("Edit time of daily notification:")
                    .multilineTextAlignment(.leading)
                DatePicker("Time:", selection: $time, displayedComponents: .hourAndMinute)
            }
            Spacer()
            
            StretchedButton(text: "Schedule", action: {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if error != nil {
                        notif = false
                    }
                }
                NotificationCTA.scheduleNotif(time: time)
                notif = true
                nextPage = true
            })
            NavigationLink(destination: OnboardingPageTwo(), isActive: $nextPage){
                EmptyView()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.secondary))
    }
}
