//
//  SideBarView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 27/04/2022.
//

import SwiftUI

struct SideBarView: View {
	@EnvironmentObject var session: FirebaseSession
	@Binding var showMenu: Bool

	var body: some View {
		VStack(alignment: .leading, spacing: 30) {
			NavigationLink(destination: YourProfileView().environmentObject(session)) {
				HStack {
					Image(systemName: "person").imageScale(.large)
					Text("Profile").font(.headline)
				}
			}
			NavigationLink(destination: UsersProjectsView().environmentObject(session)) {
				HStack {
					Image(systemName: "pencil").imageScale(.large)
					Text("Your Projects").font(.headline)
				}
			}
			NavigationLink(destination: ProposalsFeed().environmentObject(session)) {
				HStack {
					Image(systemName: "books.vertical.fill").imageScale(.large)
					Text("Proposals").font(.headline)
				}
			}
			NavigationLink(destination: SettingsView().environmentObject(session)) {
				HStack {
					Image(systemName: "gearshape.2.fill").imageScale(.large)
					Text("Settings").font(.headline)
				}
			}
			Spacer()
			Button(action: { self.session.logOut() }) {
				HStack {
					Image(systemName: "rectangle.portrait.and.arrow.right").imageScale(.large)
					Text("Logout").font(.headline)
				}
			}
		}.padding()
			.frame(maxWidth: .infinity, alignment: .leading)
			.background(Color.darkBackground)
			.foregroundColor(.white)
			.edgesIgnoringSafeArea(.bottom)
	}
}
