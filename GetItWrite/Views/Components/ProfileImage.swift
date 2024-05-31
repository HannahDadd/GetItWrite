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
			Circle().foregroundColor(GlobalVariables.profileColours[colour])
				.frame(width: 40, height: 40)
			Text(username.first?.uppercased() ?? "").foregroundColor(.white).font(.caption)
		}
    }
}

struct UsersDetails: View {
    let username: String
    let colour: Int

    var body: some View {
        HStack(spacing: 8) {
            ProfileImage(username: username, colour: colour)
            Text(username)//.font(.system(.headline, design: .rounded))
            Spacer()
        }
    }
}
