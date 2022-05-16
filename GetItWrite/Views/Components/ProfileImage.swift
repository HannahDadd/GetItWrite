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
