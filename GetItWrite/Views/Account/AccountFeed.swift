//
//  AccountFeed.swift
//  Get It Write
//
//  Created by Hannah Dadd on 02/09/2024.
//

import SwiftUI

struct AccountFeed: View {
    @EnvironmentObject var session: FirebaseSession
    @State var showSettings = false
    @State var showAccount = false
    @State var showPopUp = false
    @State var showPopUp2 = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    getTopButton(name: "gearshape.fill")
                        .onTapGesture {
                            showSettings = true
                        }
                    Spacer()
                    getTopButton(name: "person.fill")
                        .onTapGesture {
                            showAccount = true
                        }
                }
                .padding([.top, .leading, .trailing])
                HeadlineAndSubtitle(title: "Account", subtitle: "View critiques on your work and manage your account.")
                CritiquesFeedView()
                FrenziesCritiqued(isQueries: true)
                PopupPromo(title: "Written a Query Letter?", subtitle: "Get feedback from the community.", action: {
                    showPopUp = true
                })
                PositivitiesCritiqued()
                MakePositivityCard(inCarousel: false)
                    .padding()
                WIPs()
                PopupPromo(title: "Working on a Manuscript?", subtitle: "Tell others about it to find critique partners.", action: {
                    showPopUp2 = true
                })
            }
        }
        .sheet(isPresented: self.$showPopUp) {
            CreateCritiqueFrenzy(showMakeCritiqueView: self.$showPopUp, isQueries: true)
        }
        .sheet(isPresented: self.$showPopUp2) {
            MakeProposalsView(showMakeProposalView: self.$showPopUp2)
        }
        .sheet(isPresented: self.$showSettings) {
            SettingsView()
        }
        .sheet(isPresented: self.$showAccount) {
            YourProfileView()
        }
    }
    
    func getTopButton(name: String) -> AnyView {
        AnyView(Image(systemName: name)
            .resizable()
            .frame(width: 20, height: 20)
        )
    }
}
