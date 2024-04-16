//
//  CreateAccountView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/02/2022.
//

import SwiftUI

struct CreateAccountView: View {
	@EnvironmentObject var session: FirebaseSession
    let displayName: String

	@State private var bio: String = ""
	@State private var critiqueStyle: String = ""
	@State private var writing: String = ""
	@State private var authors: [String] = []
	@State private var writingGenres: [String] = []
	
	@State private var errorMessage: String = ""
	@State private var showingImagePicker = false
	@State private var inputImage: UIImage?
	
	@State var changePage = false
	
	var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    Image("Lounging").resizable().aspectRatio(contentMode: .fit).padding()
                    Text("Setup Profile").font(.largeTitle).bold().frame(maxWidth: .infinity, alignment: .leading)
                    QuestionSection(text: "Tell other writers about yourself. (Optional)", response: $bio)
                    SelectTagView(chosenTags: $writingGenres, questionLabel: "What genres do you write? (Optional)", array: GlobalVariables.genres)
                    QuestionSection(text: "Tell other writers about your writing. (Optional)", response: $writing)
                    MakeTagsCloud(array: $authors, textLabel: "Add author", questionLabel: "Who are your favourite authors? (Optional)")
                    QuestionSection(text: "Tell other writers about critique style. (Optional)", response: $critiqueStyle)
                }
            }
            Spacer()
            VStack {
                Text(errorMessage).foregroundColor(Color.red).fixedSize(horizontal: false, vertical: true)
                StretchedButton(text: "SIGN UP!", action: {
                    session.updateUser(newUser: User(id: session.user?.uid ?? "Error", displayName: displayName, bio: bio, photoURL: "", writing: writing, authors: authors, writingGenres: writingGenres, colour: session.userData?.colour ?? 1, rating: 3, critiqueStyle: critiqueStyle, blockedUserIds: []))
                        changePage = true
                })
                NavigationLink(destination: LandingPage().environmentObject(session), isActive: self.$changePage) {
                    EmptyView()
                }
            }
        }.padding().navigationBarHidden(true)
	}
}
