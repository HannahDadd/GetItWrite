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
    @State private var authors: [String] = []
    @State private var errorMessage: String = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Image("Lounging").resizable().aspectRatio(contentMode: .fit).padding()
                TextField("Display name", text: $displayName).textFieldStyle(RoundedBorderTextFieldStyle())
                TextEditor(text: $bio)
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
            Text(questionLabel).font(.caption).bold().frame(maxWidth: .infinity, alignment: .leading)
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
