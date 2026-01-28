//
//  PageOne.swift
//  Get It Write
//
//  Created by Hannah Dadd on 26/01/2026.
//

import SwiftUI

struct OnboardingPageOne: View {
    @State var nextPage = false
    
    var body: some View {
        VStack(spacing: 30) {
            NewWIP(wips: [], action: {_ in
                nextPage = true
            })
            Spacer()
            Text("Tell us about your book")
                .font(Font.custom("AbrilFatface-Regular", size: 34))
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            NavigationLink(destination: OnboardingPageTwo(), isActive: $nextPage){
                EmptyView()
            }
        }
        .padding()
    }
}
