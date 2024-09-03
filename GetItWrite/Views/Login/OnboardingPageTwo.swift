//
//  OnboardingPageTwo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 03/09/2024.
//

import SwiftUI

struct OnboardingPageTwo: View {
    @EnvironmentObject var session: FirebaseSession
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: LandingPage().environmentObject(session)) {
                        Image(systemName: "arrow.right.circle")
                                    .background(Color.primary)
                    }
                }.padding()
                Spacer()
            }
            VStack {
                Spacer()
                Image("onboardingTwo")
                Spacer()
                Text("")
                Spacer()
                StretchedButton(text: "Allow Notifications", action: {
                    
                })
                Spacer()
            }
        }
    }
}
