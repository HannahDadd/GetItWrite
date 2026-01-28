//
//  OnboardingPageThree.swift
//  Get It Write
//
//  Created by Hannah Dadd on 26/01/2026.
//

import SwiftUI

struct OnboardingPageThree: View {
    @AppStorage(UserDefaultNames.notification.rawValue) private var notif = false
    @State var nextPage = false
    @State var time = Date()
    
    var body: some View {
        VStack(spacing: 30) {
            Text("You're all set up!")
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
            
            StretchedButton(text: "Next", action: {
                nextPage = true
            })
            NavigationLink(destination: MainPage(), isActive: $nextPage){
                EmptyView()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.secondary))
    }
}
