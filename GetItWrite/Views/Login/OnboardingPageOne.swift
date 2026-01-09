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
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        session.updateUser(critiquerExpected: selected)
                        changePage = true
                    }, label: {
                        Image(systemName: "arrow.right.circle")
                                    .background(Color.primary)
                    })
                    NavigationLink(destination: OnboardingPageTwo().environmentObject(session), isActive: self.$changePage) {
                        EmptyView()
                    }
                }.padding()
                Spacer()
            }
            VStack {
                Spacer()
                Image("onboardingOne")
                Spacer()
                Text("")
                Spacer()
                Picker("What are you looking for most in a critique partner?", selection: $selected, content: {
                    ForEach(options, id: \.self) { o in
                       Text(o)
                    }
                })
                Spacer()
            }
        }
    }
}
