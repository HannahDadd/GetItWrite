//
//  ProfileImage.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 28/04/2022.
//

import SwiftUI

struct ProfileImage: View {
	let username: String
	let colour: Int = 1

    var body: some View {
		Image(systemName: username.prefix(0).lowercased() + ".square.fill")
			.foregroundColor(GlobalVariables.profileColours[colour])
    }
}
