//
//  SideBarView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 27/04/2022.
//

import SwiftUI

struct SideBarView: View {
    @EnvironmentObject var session: FirebaseSession
    @Binding var showMenu: Bool
    @State var showAlert = false
    @State var showError = false
    @State var showLogIn = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            NavigationLink(destination: YourProfileView().environmentObject(session)) {
                HStack {
                    Image(systemName: "person").imageScale(.large)
                    Text("Profile").font(.headline)
                }
            }
            NavigationLink(destination: SettingsView().environmentObject(session)) {
                HStack {
                    Image(systemName: "gearshape.2.fill").imageScale(.large)
                    Text("Settings").font(.headline)
                }
            }
            Spacer()
            if session.user == nil {
                Button(action: { showLogIn.toggle() }) {
                    HStack {
                        Image(systemName: "arrow.up.and.person.rectangle.portrait").imageScale(.large)
                        Text("Login").font(.headline)
                    }
                }
            } else {
                Button(action: {
                    session.logOut { error in
                        if error != nil {
                            showError = true
                        }
                    }
                    showMenu.toggle()
                }) {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right").imageScale(.large)
                        Text("Logout").font(.headline)
                    }
                }
                Button(action: { showAlert = true }) {
                    HStack {
                        Image(systemName: "trash.fill").imageScale(.large)
                        Text("Delete Account").font(.headline)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.darkBackground)
        .foregroundColor(.white)
        .edgesIgnoringSafeArea(.bottom)
        .alert("Are you sure you want to permanently delete your account and all its data? This cannot be undone.", isPresented: $showAlert, actions: {
            Button("Destructive", role: .destructive, action: deleteAccount)
        })
        .alert("There was a problem. Try again later.", isPresented: $showError, actions: {})
        .sheet(isPresented: $showLogIn, onDismiss: {
            showMenu.toggle()
        }) {
            LoginView()
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
