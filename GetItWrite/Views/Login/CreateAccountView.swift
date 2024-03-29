//
//  CreateAccountView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/02/2022.
//

import SwiftUI

struct CreateAccountView: View {
	@EnvironmentObject var session: FirebaseSession
	
	@State private var displayName: String = ""
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
		ScrollView {
			VStack(spacing: 20) {
				Image("Lounging").resizable().aspectRatio(contentMode: .fit).padding()
				Text("Setup Profile").font(.largeTitle).bold().frame(maxWidth: .infinity, alignment: .leading)
				VStack {
					TextField("Display name", text: $displayName).textFieldStyle(RoundedBorderTextFieldStyle())
//					if let inputImage = inputImage {
//						Image(uiImage: inputImage).resizable().aspectRatio(contentMode: .fit)
//						StretchedButton(text: "Change Profile Picture", action: { self.showingImagePicker = true })
//					} else {
//						StretchedButton(text: "Add Optional Profile Picture", action: { self.showingImagePicker = true })
//					}
				}
				QuestionSection(text: "Tell other writers about yourself.", response: $bio)
				SelectTagView(chosenTags: $writingGenres, questionLabel: "What genres do you write?", array: GlobalVariables.genres)
				QuestionSection(text: "Tell other writers about your writing.", response: $writing)
				MakeTagsCloud(array: $authors, textLabel: "Add author", questionLabel: "Who are your favourite authors?")
				QuestionSection(text: "Tell other writers about critique style.", response: $critiqueStyle)
				VStack {
					Text(errorMessage).foregroundColor(Color.red).fixedSize(horizontal: false, vertical: true)
					StretchedButton(text: "SIGN UP!", action: {
						if displayName == "" {
							errorMessage = "You must have a display name."
						} else if bio == "" {
							errorMessage = "Please tell others about yourself in your bio- this can be as simple as your favourite colour."
						} else if critiqueStyle == "" {
							errorMessage = "Please tell potential critique partners what your critique style is like. e.g. are you a line editer, grammar nut, more into overall feedback or all of them!"
						} else if writing == "" {
							errorMessage = "Please tell potential critique partners about your writing- what you like to write, any achievements and what you're currently working on."
						} else if authors == [] {
							errorMessage = "Please select at least one favourite author."
						} else if writingGenres == [] {
							errorMessage = "Please select at least one genre you like to write."
						} else {
                            session.updateUser(newUser: User(id: session.user?.uid ?? "Error", displayName: displayName, bio: bio, photoURL: "", writing: writing, authors: authors, writingGenres: writingGenres, colour: Int.random(in: 0..<GlobalVariables.profileColours.count), rating: 3, critiqueStyle: critiqueStyle, blockedUserIds: []))
							changePage = true
						}
					})
					NavigationLink(destination: LandingPage().environmentObject(session), isActive: self.$changePage) {
						EmptyView()
					}
				}
			}.padding().navigationBarHidden(true)
				.sheet(isPresented: $showingImagePicker, onDismiss: {
					//                self.session.uploadProfiePic(uiImage: self.inputImage)
				}) {
					ImagePicker(image: self.$inputImage)
				}
		}
	}
}
