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
		Image(systemName: username.prefix(1).lowercased() + ".square.fill")
			.foregroundColor(GlobalVariables.profileColours[colour])
    }
}
