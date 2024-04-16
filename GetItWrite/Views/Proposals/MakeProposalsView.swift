//
//  MakeProposalsView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 19/05/2022.
//

import SwiftUI

struct MakeProposalsView: View {
    @EnvironmentObject var session: FirebaseSession
    
    @State private var authorsNotes: String = ""
    @State var wordCount: String = ""
    @State var typeOfProject: [String] = []
    @State private var title: String = ""
    @State var blurb: String = ""
    @State var genres: [String] = []
    @State var triggerWarnings: [String] = []
    @State private var errorMessage: String = ""
    
    @Binding var showMakeProposalView: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    TextField("Title", text: $title).textFieldStyle(RoundedBorderTextFieldStyle())
                    QuestionSection(text: "Blurb", response: $blurb)
                    SelectTagView(chosenTags: $genres, questionLabel: "Genre of piece:", array: GlobalVariables.genres)
                    MakeTagsCloud(array: $triggerWarnings, textLabel: "Add warnings", questionLabel: "Add any trigger warnings for your project here.")
                    ErrorText(errorMessage: errorMessage)
                    QuestionSection(text: "Author's Notes", response: $authorsNotes)
                    TextField("Word Count", text: $wordCount).textFieldStyle(RoundedBorderTextFieldStyle())
                    SelectTagView(chosenTags: $typeOfProject, questionLabel: "What do you need Critiquing:", array: GlobalVariables.typeOfProject)
                    Spacer()
                    ErrorText(errorMessage: errorMessage)
                    StretchedButton(text: "Upload", action: {
                        if title == "" {
                            errorMessage = "Your project needs a title!"
                        } else if let wordCountNum = Int(wordCount) {
                            session.newProposal(title: title, blurb: blurb, genres: genres, triggerWarnings: triggerWarnings, wordCount: wordCountNum, authorNotes: authorsNotes, typeOfProject: typeOfProject) { err in
                                if let err {
                                    errorMessage = "Whoops something went wrong! Try again later. Error message: \(err.localizedDescription)"
                                } else {
                                    self.showMakeProposalView.toggle()
                                }
                            }
                        } else {
                            errorMessage = "Word count needs to be a number. Characters like 'k' or ',' are not allowed."
                        }
                    })
                }.padding()
            }.navigationBarItems(
                trailing: Button(action: { self.showMakeProposalView.toggle() }) {
                    Text("Cancel")
                }).navigationBarTitle(Text("Request Critiques"), displayMode: .inline)
        }.accentColor(Color.darkText)
    }
}
