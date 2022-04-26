//
//  ProfileView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 25/04/2022.
//

import SwiftUI

struct ProfileView: View {
	@EnvironmentObject var session: FirebaseSession
	
	var body: some View {
		VStack(spacing: 8) {
			Text(session.userData?.displayName ?? "").font(.title)
			Text(session.userData?.bio ?? "")
			Text("Favourite Authors").bold()
			TagCloud(tags: session.userData?.authors ?? [], onTap: nil, chosenTag: .constant(""), singleTagView: false)
			List {
				NavigationLink(destination: CreateAccountView()) {
					Text("Edit Profile")
				}
				Button(action: {}) {
					Text("Settings")
				}
				Button(action: {}) {
					Text("FAQs")
				}
				Button(action: { self.session.logOut() }) {
					Text("Logout")
				}
			}
			HStack(alignment: .bottom) {
				Button(action: {}) {
					Text("Update Email")
						.foregroundColor(Color.black)
				}
				Spacer()
				Button(action: {}) {
					Text("Change Password")
						.foregroundColor(Color.black)
				}
			}.padding()
		}
	}
}
