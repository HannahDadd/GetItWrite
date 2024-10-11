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
        ZStack {
            VStack(spacing: 8) {
                Spacer()
                ZStack {
                    Image("page1")
                        .resizable()
                        .frame(height: 400)
                    VStack {
                        Text("Critique partners improve your writing, offer emotional support and encourage you to reach your writing goals.").bold()
                        Spacer()
                    }
                }
                Spacer()
                Text("\(displayName), what are you looking for most in a critique partner?")
                Picker("", selection: $selected, content: {
                    ForEach(options, id: \.self) { o in
                       Text(o)
                    }
                })
                Spacer()
            }.padding()
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        session.updateUser(critiquerExpected: selected)
                        changePage = true
                    }, label: {
                        OnboardingArrow()
                    })
                    NavigationLink(destination: OnboardingPageTwo(), isActive: self.$changePage) {
                        EmptyView()
                    }
                }.padding()
                Spacer()
            }
        }
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
