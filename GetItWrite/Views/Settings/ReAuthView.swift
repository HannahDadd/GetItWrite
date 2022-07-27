//
//  ReAuthView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 27/07/2022.
//

import SwiftUI

struct ReAuthView: View {
	@EnvironmentObject var session: FirebaseSession
	let isChangePassword: Bool
	
	@State var email: String = ""
	@State var password: String = ""
	@State private var errorMessage: String = ""
	@State var showChangePasswordScreen = false
	@State var showChangeEmailScreen = false
	
	var body: some View {
		NavigationView {
			VStack {
				Text("Reauthenticate").font(.largeTitle).bold().frame(maxWidth: .infinity, alignment: .leading)
				VStack {
					TextField("Email", text: $email).textFieldStyle(RoundedBorderTextFieldStyle())
					SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
				}
				StretchedButton(text: "AUTHENTICATE", action: reAuth)
				ErrorText(errorMessage: errorMessage)
				NavigationLink(destination: ChangePasswordScreen().environmentObject(session), isActive: self.$showChangePasswordScreen) {
					EmptyView()
				}
			}.padding().navigationBarHidden(true)
		}
	}
	
	func reAuth() {
		self.session.reauthenticate(email: email, password: password) { (result, error) in
			if let error = error {
				errorMessage = error.localizedDescription
			} else {
				if isChangePassword {
					showChangePasswordScreen.toggle()
				} else {
					showChangeEmailScreen.toggle()
				}
			}
		}
	}
}
