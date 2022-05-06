//
//  SettingsView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 06/05/2022.
//

import SwiftUI

struct SettingsView: View {
	@EnvironmentObject var session: FirebaseSession
	@State private var notifications = true

	var body: some View {
		Form {
			Section {
				Toggle(isOn: $notifications) {
					VStack(alignment: .leading, spacing: 8) {
						Text("Notifications")
						Text("Notifications are sent when you receive a critique or a rating which allows you to upload a new post.").font(.caption)
					}
				}.tint(.lightBackground)
			}
			Section {
				Button(action: {}) {
					Text("Terms of Use")
				}
				Button(action: { }) {
					Text("About")
				}
				Button(action: { }) {
					Text("How does Get It Write Work")
				}
				Button(action: {}) {
					Text("Change email")
				}
				Button(action: { }) {
					Text("Update password")
				}
			}
		}.navigationBarTitle(Text("Settings"), displayMode: .inline)
	}
}
