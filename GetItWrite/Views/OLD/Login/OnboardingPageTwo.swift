//
//  OnboardingPageTwo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 03/09/2024.
//

import SwiftUI
import UserNotifications

struct OnboardingPageTwo: View {
    @EnvironmentObject var session: FirebaseSession
    @State var changePage = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Need updates from your writing community?")
                    .font(Font.custom("AbrilFatface-Regular", size: 34))
                    .foregroundStyle(Color.onSecondary)
                Spacer()
                ErrorText(errorMessage: errorMessage)
                StretchedButton(text: "Allow Notifications", action: {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            changePage = true
                        } else if error != nil {
                            errorMessage = "Failed to allow notifications."
                        }
                    }
                })
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.secondary)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        changePage = true
                    }, label: {
                        OnboardingArrow()
                    })
                    NavigationLink(destination: LandingPage(), isActive: self.$changePage) {
                        EmptyView()
                    }
                }.padding()
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
