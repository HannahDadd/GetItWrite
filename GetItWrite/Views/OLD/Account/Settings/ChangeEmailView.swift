//
//  ChangeEmailView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 27/07/2022.
//

import SwiftUI

struct ChangeEmailView: View {
	@EnvironmentObject var session: FirebaseSession

	@State var email: String = ""
	@State var changePage = false
	@State private var errorMessage: String = ""

	var body: some View {
		VStack {
			Text("Update Email").font(.largeTitle).bold().frame(maxWidth: .infinity, alignment: .leading)
			TextField("Email", text: $email).textFieldStyle(RoundedBorderTextFieldStyle())
			Spacer()
			Text(errorMessage).foregroundColor(Color.red).fixedSize(horizontal: false, vertical: true)
			StretchedButton(text: "UPDATE EMAIL", action: changeEmail)
			NavigationLink(destination: SuccessEmailChangeView(), isActive: self.$changePage) {
				EmptyView()
			}
		}.padding().navigationBarHidden(true)
	}

	func changeEmail() {
		if email.isEmpty {
			errorMessage = "Please provide an email"
		} else {
			session.changeEmail(email: email) { error in
				if let error = error {
					errorMessage = error.localizedDescription
				} else {
					changePage = true
				}
			}
		}
	}
}

struct SuccessEmailChangeView: View {

	var body: some View {
		Text("✅ Email Updated").padding().navigationBarHidden(true)
	}
}
