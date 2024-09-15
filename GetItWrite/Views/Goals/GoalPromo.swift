//
//  GoalPromo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 05/09/2024.
//

import SwiftUI

struct GoalPromo: View {
    @State var showPopUp = false

    var body: some View {
        VStack {
            ImagePromo(image: "aibg", text: "Get instant AI feedback on your writing.", bubbleText: "Give it a go") {
                showPopUp = true
            }
        }
        .sheet(isPresented: self.$showPopUp) {
            AIReview()
        }
    }
}

struct MakeGoal: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var selected = "Confidence Builder"
    @State var changePage = false
    
    let displayName: String
    
    private let options = [
        "Plotting",
        "Writing",
        "Editing",
        "Querying"
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
                        OnboardingArrow()
                    })
                    NavigationLink(destination: OnboardingPageTwo(), isActive: self.$changePage) {
                        EmptyView()
                    }
                }.padding()
                Spacer()
            }
            VStack(spacing: 8) {
                Spacer()
                Image("onboardingOne")
                Spacer()
                Text("").bold()
                Spacer()
                Text("\(displayName), what are you looking for most in a critique partner?")
                Picker("", selection: $selected, content: {
                    ForEach(options, id: \.self) { o in
                       Text(o)
                    }
                })
                Spacer()
            }.padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}
