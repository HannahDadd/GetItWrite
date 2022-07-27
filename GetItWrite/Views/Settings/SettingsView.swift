//
//  SettingsView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 06/05/2022.
//

import SwiftUI

struct SettingsView: View {
	@EnvironmentObject var session: FirebaseSession

	@State private var changeEmailView = false
	@State private var changePasswordView = false

	var body: some View {
		Form {
//			Section {
//				Toggle(isOn: $notifications) {
//					VStack(alignment: .leading, spacing: 8) {
//						Text("Notifications").font(.title3)
//						Text("Notifications are sent when you receive a critique or a rating which allows you to upload a new post.")
//					}
//				}.tint(.lightBackground)
//			}
			Section {
				Button(action: {}) {
					Text("Terms of Use")
				}
				Button(action: { }) {
					Text("About")
				}
				Button(action: { changeEmailView.toggle() }) {
					Text("Change email")
				}
				Button(action: { changePasswordView.toggle() }) {
					Text("Update password")
				}
			}
		}.navigationBarTitle(Text("Settings"), displayMode: .inline)
			.sheet(isPresented: self.$changeEmailView) {
				ReAuthView(isChangePassword: false).environmentObject(session)
			}
			.sheet(isPresented: self.$changePasswordView) {
				ReAuthView(isChangePassword: true).environmentObject(session)
			}
	}
}
