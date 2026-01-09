//
//  LandingPage.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 15/07/2023.
//

import SwiftUI

struct LandingPage: View {
    @EnvironmentObject var session: FirebaseSession
//    @AppStorage("hasntAcceptedTsAndCs") var hasntAcceptedTsAndCs = true
    @State var showMenu = false
    @State private var selection = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                TabView(selection: $selection) {
                    Homepage().environmentObject(session)
                        .tabItem {
                            Image(systemName: "house.fill")
                        }
                        .tag(0)
                    QueryHomepage().environmentObject(session)
                        .tabItem {
                            Image(systemName: "mail.fill")
                        }
                        .tag(1)
                    SearchPage().environmentObject(session)
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                        }
                        .tag(2)
                    AccountFeed().environmentObject(session)
                        .tabItem {
                            Image(systemName: "pencil")
                        }
                        .tag(3)
                    AllChatsView().environmentObject(session)
                        .tabItem {
                            Image(systemName: "message.fill")
                        }
                        .tag(4)
                }
                .toolbarBackground(Color.secondary, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                .disabled(self.showMenu ? true : false)
                if self.showMenu {
                    SideBarView(showMenu: $showMenu).environmentObject(session).frame(width: geometry.size.width/2, height: geometry.size.height)
                        .transition(.move(edge: .leading))
                }
            }
        }
//        .alert("We've updated our Terms and Conditions! Please review them in the settings. By continuing to use the app you agree to the updated terms and conditions.", isPresented: $hasntAcceptedTsAndCs) {
//                    Button("OK", role: .cancel) { hasntAcceptedTsAndCs = false }
//                }
        .navigationBarTitleDisplayMode(.inline).toolbar {
            ToolbarItem(placement: .principal) {
                Image("Words").resizable().aspectRatio(contentMode: .fit)
            }
        }.navigationBarItems(
            leading: Button(action: {
                withAnimation {
                    showMenu.toggle()
                }
            }) {
                Image(systemName: "line.3.horizontal")
                    .foregroundColor(Color.onSecondary)
            })
        .onAppear(perform: {
                showMenu = false
            }
        ).navigationBarBackButtonHidden(true)
    }
}
