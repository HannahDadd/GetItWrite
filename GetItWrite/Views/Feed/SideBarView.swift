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
			NavigationLink(destination: ProfileView().environmentObject(session)s) {
				HStack {
					Image(systemName: "person").imageScale(.large)
					Text("Profile").font(.headline)
				}
			}
			NavigationLink(destination: ProfileView().environmentObject(session)) {
				HStack {
					Image(systemName: "pencil").imageScale(.large)
					Text("Your Work").font(.headline)
				}
			}
			NavigationLink(destination: ProfileView().environmentObject(session)) {
				HStack {
					Image(systemName: "gearshape.2.fill").imageScale(.large)
					Text("Settings").font(.headline)
				}
			}
			Spacer()
			HStack {
				Image(systemName: "rectangle.portrait.and.arrow.right").imageScale(.large)
				Text("Logout").font(.headline)
			}
		}.padding()
			.frame(maxWidth: .infinity, alignment: .leading)
			.background(Color.darkBackground)
			.foregroundColor(.white)
			.edgesIgnoringSafeArea(.bottom)
	}
}
