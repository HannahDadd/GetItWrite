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
            VStack {
                Spacer()
                Text("Receive updates from Get it Write.").bold()
                Spacer()
                Image("page2")
                    .resizable()
                    .frame(height: 400)
                Spacer()
                ErrorText(errorMessage: errorMessage)
                StretchedButton(text: "Allow Notifications", action: {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            changePage = true
                        } else if let error {
                            errorMessage = "Failed to allow notifications."
                        }
                    }
                })
                Spacer()
            }.padding()
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
