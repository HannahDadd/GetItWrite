//
//  OnboardingPageOne.swift
//  Get It Write
//
//  Created by Hannah Dadd on 03/09/2024.
//

import SwiftUI

struct OnboardingPageOne: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var selected = "Confidence Builder"
    @State var changePage = false
    
    let displayName: String
    
    private let options = [
        "Confidence Builder",
        "Honest Feedback Giver",
        "Query Package Evaluator",
        "Accountability Partner",
        "Writing Pal"
    ]
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Critique partners improve, support and encourage your writing.")
                .font(Font.custom("AbrilFatface-Regular", size: 34))
                .foregroundStyle(Color.onSecondary)
            Spacer()
            Text("\(displayName), what are you looking for most in a critique partner?")
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.onSecondary)
            Picker("", selection: $selected, content: {
                ForEach(options, id: \.self) { o in
                    Text(o)
                }
            }).tint(Color.onSecondary)
            StretchedButton(text: "Next") {
                session.updateUser(critiquerExpected: selected)
                changePage = true
            }
            NavigationLink(destination: OnboardingPageTwo(), isActive: self.$changePage) {
                EmptyView()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.secondary)
        .navigationBarBackButtonHidden(true)
    }
}

struct OnboardingArrow: View {
    var body: some View {
        Image(systemName: "arrow.right")
            .resizable()
            .frame(width: 25, height: 25)
            .padding()
            .background(Color.primary)
            .foregroundColor(Color.onPrimary)
            .clipShape(Circle())
    }
}
