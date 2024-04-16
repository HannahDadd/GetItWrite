//
//  EditProfileView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 05/05/2022.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var session: FirebaseSession
    
    @State private var bio: String = ""
    @State private var critiqueStyle: String = ""
    @State private var writing: String = ""
    @State private var authors: [String] = []
    @State private var writingGenres: [String] = []
    @State private var errorMessage: String = ""
    
    let colour: Int
    let rating: Int
    
    init(session: FirebaseSession) {
        if let user = session.userData {
            bio = user.bio
            critiqueStyle = user.critiqueStyle
            writing = user.writing
            authors = user.authors
            writingGenres = user.writingGenres
            colour = user.colour
            rating = user.rating
        } else {
            colour = 1
            rating = 1
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Edit Profile").font(.largeTitle).bold().frame(maxWidth: .infinity, alignment: .leading)
                QuestionSection(text: "Bio", response: $bio)
                SelectTagView(chosenTags: $writingGenres, questionLabel: "What genres do you write?", array: GlobalVariables.genres)
                QuestionSection(text: "Writing", response: $writing)
                MakeTagsCloud(array: $authors, textLabel: "Add author", questionLabel: "Who are your favourite authors?")
                QuestionSection(text: "Critique style", response: $critiqueStyle)
                VStack {
                    Text(errorMessage).foregroundColor(Color.red).fixedSize(horizontal: false, vertical: true)
                    StretchedButton(text: "Save Changes", action: {
                        session.updateUser(newUser: User(id: session.user?.uid ?? "Error", displayName: session.userData?.displayName ?? "", bio: bio, photoURL: "", writing: writing, authors: authors, writingGenres: writingGenres, colour: colour, rating: rating, critiqueStyle: critiqueStyle, blockedUserIds: session.userData?.blockedUserIds ?? []))
                    })
                }
            }.padding()
        }
    }
}
