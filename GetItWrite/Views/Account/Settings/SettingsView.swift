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
    @State private var tAndCsView = false
    @State private var ppView = false
    @State var showAlert = false
    @State var showError = false
    
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
                Button(action: { tAndCsView.toggle() }) {
                    Text("Terms of Use")
                }.buttonStyle(PlainButtonStyle())
                Button(action: { ppView.toggle() }) {
                    Text("Privacy Policy")
                }.buttonStyle(PlainButtonStyle())
                if session.user != nil {
                    Button(action: { changeEmailView.toggle() }) {
                        Text("Change email")
                    }.buttonStyle(PlainButtonStyle())
                    Button(action: { changePasswordView.toggle() }) {
                        Text("Update password")
                    }.buttonStyle(PlainButtonStyle())
                }
            }
            Section {
                Button(action: {
                    session.logOut { error in
                        if error != nil {
                            showError = true
                        }
                    }
                }) {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right").imageScale(.large)
                        Text("Logout").font(.headline)
                    }
                }.buttonStyle(PlainButtonStyle())
                Button(action: { showAlert = true }) {
                    HStack {
                        Image(systemName: "trash.fill").imageScale(.large)
                        Text("Delete Account").font(.headline)
                    }
                }.buttonStyle(PlainButtonStyle())
            }
        }
        .alert("Are you sure you want to permanently delete your account and all its data? This cannot be undone.", isPresented: $showAlert, actions: {
            Button("Destructive", role: .destructive, action: deleteAccount)
        })
        .alert("There was a problem. Try again later.", isPresented: $showError, actions: {})
        .sheet(isPresented: self.$changeEmailView) {
            ReAuthView(isChangePassword: false).environmentObject(session)
        }
        .sheet(isPresented: self.$changePasswordView) {
            ReAuthView(isChangePassword: true).environmentObject(session)
        }
        .sheet(isPresented: self.$tAndCsView) {
            TsAndCsView()
        }
        .sheet(isPresented: self.$ppView) {
            PrivacyPolicyView()
        }
    }
    
    func deleteAccount() {
        session.deleteAccount() { error in
            if error != nil {
                showError = true
            }
        }
    }
}
