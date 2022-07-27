//
//  ChangePasswordView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 27/07/2022.
//

import SwiftUI

struct ChangePasswordView: View {
	@Environment(\.presentationMode) var presentation
	@EnvironmentObject var session: FirebaseSession

	@State private var password: String = ""
	@State private var errorMessage: String = ""
	@State private var confirmPassword: String = ""
	@State var changePage = false

	var body: some View {
		VStack {
			Text("Change Password").font(.largeTitle).bold().frame(maxWidth: .infinity, alignment: .leading)
			TextField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
			TextField("Confirm password", text: self.$confirmPassword).textFieldStyle(RoundedBorderTextFieldStyle())
			StretchedButton(text: "SIGN UP", action: changePassword)
			Text(errorMessage).foregroundColor(Color.red).fixedSize(horizontal: false, vertical: true)
			NavigationLink(destination: SuccessPasswordChangeView(), isActive: self.$changePage) {
				EmptyView()
			}
		}.padding().navigationBarHidden(true)
	}

	func changePassword() {
		if password.isEmpty {
			errorMessage = "Please provide a password"
		} else if password == confirmPassword {
			session.changePassword(password: password) { error in
				if let error = error {
					errorMessage = error.localizedDescription
				} else {
					changePage = true
				}
			}
		} else {
			errorMessage = "Passwords do not match"
		}
	}
}

struct SuccessPasswordChangeView: View {

	var body: some View {
		Text("✅ Password Changed").padding().navigationBarHidden(true)
	}
}
