//
//  LandingPage.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 15/07/2023.
//

import SwiftUI

struct LandingPage: View {
    @EnvironmentObject var session: FirebaseSession
    @State var showMenu = false
    @State private var selection = 2
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                TabView(selection: $selection) {
                    CritiqueFrenzyView().environmentObject(session)
                        .tabItem {
                            Label("Critique Frenzy", systemImage: "checklist")
                        }
                        .tag(0)
                    FeedView().environmentObject(session)
                        .tabItem {
                            Label("To Critique", systemImage: "pencil")
                        }
                        .tag(1)
                    ForumView().environmentObject(session)
                        .tabItem {
                            Label("Forum", systemImage: "house.fill")
                        }
                        .tag(2)
                    AllChatsView().environmentObject(session)
                        .tabItem {
                            Label("Messages", systemImage: "message")
                        }
                        .tag(3)
                    ProposalsFeed().environmentObject(session)
                        .tabItem {
                            Label("Find Partners", systemImage: "books.vertical.fill")
                        }
                        .tag(4)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                .disabled(self.showMenu ? true : false)
                if self.showMenu {
                    SideBarView(showMenu: $showMenu).environmentObject(session).frame(width: geometry.size.width/2, height: geometry.size.height)
                        .transition(.move(edge: .leading))
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline).toolbar {
            ToolbarItem(placement: .principal) {
                Image("Words").resizable().aspectRatio(contentMode: .fit)
            }
        }.navigationBarItems(
            leading: Button(action: {
                withAnimation {
                    showMenu.toggle()
                }
            }) { Image(systemName: "line.3.horizontal") })
        .onAppear(perform: {
                showMenu = false
                //session.populateDatabaseFakeData()
            }
        ).navigationBarBackButtonHidden(true)
    }
}
