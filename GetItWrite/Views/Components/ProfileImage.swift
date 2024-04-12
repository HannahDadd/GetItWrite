//
//  ProfileImage.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 28/04/2022.
//

import SwiftUI

struct ProfileImage: View {
	let username: String
	let colour: Int

    var body: some View {
		ZStack {
			Rectangle().foregroundColor(GlobalVariables.profileColours[colour])
				.frame(width: 20, height: 20)
			Text(username.first?.uppercased() ?? "").foregroundColor(.white).font(.caption)
		}
    }
}

struct UsersDetails: View {
    let username: String
    let colour: Int

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            ProfileImage(username: username, colour: colour)
            Text(username).bold().font(.system(.subheadline, design: .rounded))
            Spacer()
        }
    }
}
