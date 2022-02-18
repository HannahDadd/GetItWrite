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
    @State private var writing: String = ""
    @State private var authors: [String] = []
    @State private var writingGenres: [String] = []
    @State private var errorMessage: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Image("Lounging").resizable().aspectRatio(contentMode: .fit).padding()
                Text("Create Account").font(.largeTitle).bold().frame(maxWidth: .infinity, alignment: .leading)
                TextField("Display name", text: $displayName).textFieldStyle(RoundedBorderTextFieldStyle())
                VStack {
                    Text("Tell other writers about yourself.").bold().frame(maxWidth: .infinity, alignment: .leading)
                    TextEditor(text: $bio)
                        .frame(height: 100, alignment: .leading)
                        .cornerRadius(6.0)
                        .border(Color.gray, width: 1)
                        .multilineTextAlignment(.leading)
                }
                SelectTagView(chosenTags: $writingGenres, questionLabel: "What genres do you write?", array: ["Young Adult", "Adult", "Middle Grade", "Fantasy", "Magical Realism", "Histroical", "Romance", "Science Fiction", "Women's Fiction", "Short Stories", "Dystopian", "Mystery", "Thriller"])
                Text("Tell other writers about your writing.").bold().frame(maxWidth: .infinity, alignment: .leading)
                TextEditor(text: $writing)
                    .frame(height: 100, alignment: .leading)
                    .cornerRadius(6.0)
                    .border(Color.gray, width: 1)
                    .multilineTextAlignment(.leading)
                TagBoxView(array: $authors, textLabel: "Add author", questionLabel: "Who are your favourite authors?")
                Text(errorMessage).foregroundColor(Color.red).fixedSize(horizontal: false, vertical: true)
                Button(action: {}) {
                    Text("SIGN UP!").bold()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.darkReadable)
                        .overlay(RoundedRectangle(cornerRadius: 5))
                }.accentColor(Color.clear)
            }.padding().navigationBarTitle(Text("Create Account"), displayMode: .inline)
        }
    }
}

struct TagBoxView: View {
    @Binding var array: [String]
    @State private var value: String = ""
    let textLabel: String
    let questionLabel: String

    var body: some View {
        VStack {
            Text(questionLabel).bold().frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                TextField(textLabel, text: self.$value)
                Button(action: {
                    if value != "" {
                        self.array.append(self.value)
                        self.value = ""
                    }
                }) {
                    Image(systemName: "plus.circle")
                }
            }
            Text("Tap tags to remove").font(.caption)
            TagCloud(tags: self.array, onTap: { text in
                self.array = self.array.filter { $0 != text }
            })
        }
    }
}

struct SelectTagView: View {
    @Binding var chosenTags: [String]
    @State private var value: String = ""
    let questionLabel: String
    let array: [String]

    var body: some View {
        VStack {
            Text(questionLabel).bold().frame(maxWidth: .infinity, alignment: .leading)
            TagCloud(tags: array, onTap: { text in
                chosenTags.append(text)
            })
        }
    }
}
