//
//  ProfileView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 25/04/2022.
//

import SwiftUI

struct YourProfileView: View {
	@EnvironmentObject var session: FirebaseSession
	
	var body: some View {
			ScrollView {
			 VStack(spacing: 25) {
			 Text(session.userData?.displayName ?? "").font(.title)
			 TextAndHeader(heading: "Bio", text: session.userData?.bio ?? "")
			 TextAndTags(heading: "Favourite Authors", tags: session.userData?.authors ?? [])
			 TextAndHeader(heading: "Writing", text: session.userData?.writing ?? "")
			 TextAndTags(heading: "Writing Genres", tags: session.userData?.writingGenres ?? [])
			 }.padding()
		 }.navigationBarItems(
			 trailing: Button(action: {  }) {
					Text("Edit Profile")
				})
	}
}
