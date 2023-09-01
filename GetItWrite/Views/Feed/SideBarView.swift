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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            NavigationLink(destination: YourProfileView().environmentObject(session)) {
                HStack {
                    Image(systemName: "person").imageScale(.large)
                    Text("Profile").font(.headline)
                }
            }
            NavigationLink(destination: AllChatsView().environmentObject(session)) {
                HStack {
                    Image(systemName: "message").imageScale(.large)
                    Text("Messages").font(.headline)
                }
            }
            NavigationLink(destination: SettingsView().environmentObject(session)) {
                HStack {
                    Image(systemName: "gearshape.2.fill").imageScale(.large)
                    Text("Settings").font(.headline)
                }
            }
            Spacer()
            Button(action: session.logOut) {
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
        }.alert("Are you sure you want to permanently delete your account and all its data? This cannot be undone.", isPresented: $showAlert, actions: {
            Button("Destructive", role: .destructive, action: deleteAccount)
        }).alert("There was a problem deleting your account. Try again later.", isPresented: $showError, actions: {})
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.darkBackground)
        .foregroundColor(.white)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    func deleteAccount() {
        session.deleteAccount() { error in
            if error != nil {
                showError = true
            }
        }
    }
}
