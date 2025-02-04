//
//  ProfileView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 25/04/2022.
//

import SwiftUI

struct YourProfileView: View {
    @EnvironmentObject var session: FirebaseSession
    @State var nextPage = false
    
    var body: some View {
        NavigationView {
            if session.user == nil {
                Text("Sign in to create a profile.")
            } else {
                ZStack {
                    ScrollView {
                        VStack(spacing: 25) {
                            Text(session.userData?.displayName ?? "").font(.title)
                            TextAndHeader(heading: "Bio", text: session.userData?.bio ?? "")
                            TextAndTags(heading: "Favourite Authors", tags: session.userData?.authors ?? [])
                            TextAndHeader(heading: "Writing", text: session.userData?.writing ?? "")
                            TextAndTags(heading: "Writing Genres", tags: session.userData?.writingGenres ?? [])
                            TextAndHeader(heading: "Critique Style", text: session.userData?.critiqueStyle ?? "")
                        }.padding()
                    }
                    VStack {
                        Spacer()
                        StretchedButton(text: "Edit Profile", action: {
                            nextPage = true
                        }).padding()
                    }
                    NavigationLink(destination: EditProfileView(session: session).environmentObject(session), isActive: self.$nextPage) {
                        EmptyView()
                    }
                }
            }
        }
    }
}
