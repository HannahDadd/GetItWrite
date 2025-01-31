//
//  GiveCritiqueView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 22/04/2022.
//

import SwiftUI
import FirebaseFirestore

struct GiveCritiqueView: View {
    @EnvironmentObject var session: FirebaseSession
    
    @State private var wordTapped = false
    @State private var backToFeed = false
    @State private var showingError = false
    @State var chosenWord: String = ""
    @State private var comment = ""
    @State private var instance = 0
    
    @State private var overallComments = ""
    @State private var comments = [Int : String]()
    @State private var errorMessagePopup: String = ""
    @State private var errorMessage: String = ""
    
    @State private var pacing = 0
    @State private var writingStyle = 0
    @State private var voice = 0
    @State private var readOn = false
    
    let requestCritique: RequestCritique
    let paragraphs: [String]
    
    init(requestCritique: RequestCritique) {
        paragraphs = requestCritique.text.components(separatedBy: "\n")
        self.requestCritique = requestCritique
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                if !requestCritique.title.contains("Frenzy") {
                    Text(requestCritique.workTitle).font(.title)
                    Text(requestCritique.title).font(.title3)
                    Text("By \(requestCritique.writerName)")
                    TagCloud(tags: requestCritique.genres, onTap: nil, chosenTags: .constant([]), singleTagView: false)
                    if requestCritique.triggerWarnings.count > 0 {
                        Divider()
                        Text("Trigger Warnings:").font(.footnote)
                        TagCloud(tags: requestCritique.triggerWarnings, chosenTags: .constant([]), singleTagView: false)
                    }
                    Divider()
                    Text("Blurb").bold()
                    Text(requestCritique.blurb)
                    Divider()
                }
            }
            ForEach(0..<paragraphs.count, id: \.self) { i in
                Text(paragraphs[i]).frame(maxWidth: .infinity, alignment: .leading)
                    .background(chosenWord == paragraphs[i] && wordTapped ? .yellow : comments[i] != nil ? Color.primary : .clear)
                    .onTapGesture {
                        wordTapped.toggle()
                        if wordTapped {
                            chosenWord = paragraphs[i]
                            comment = comments[i] ?? ""
                            instance = i
                        }
                    }.padding(.bottom, 8)
            }
            ReportAndBlockView(content: requestCritique, contentType: .requestCritiques, toBeBlockedUserId: requestCritique.writerId, imageScale: .large)
            Spacer()
            VStack {
                Divider()
                Text("Comments: \(comments.count)").font(.caption)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                //if requestCritique.title != "Query Frenzy" {
                VStack(spacing: 16) {
                    StarRating(title: "Pacing", number: $pacing)
                    StarRating(title: "Writing Style", number: $writingStyle)
                    StarRating(title: "Voice", number: $voice)
                }
                //}
                Toggle(isOn: $readOn, label: {
                    Text("Would you read on?").bold()
                })
                QuestionSection(text: "Overall Feedback:", response: $overallComments)
                StretchedButton(text: "Submit Critique", action: {
                    var feedback = "Overall feedback: \n\(overallComments)\nWould read on: \(readOn)"
                    feedback = "Pacing: \(pacing)/5\nWriting Style: \(writingStyle)/5\nVoice: \(voice)/5\n" + feedback
                    session.submitCritique(requestCritique: requestCritique, comments: comments, overallFeedback: feedback) {error in
                        if let error {
                            errorMessage = error.localizedDescription
                        } else {
                            session.updateUser(lastCritique: Timestamp())
                            backToFeed = true
                        }
                    }
                })
                ErrorText(errorMessage: errorMessage)
            }
            NavigationLink(destination: LandingPage().environmentObject(session), isActive: self.$backToFeed) {
                EmptyView()
            }
        }
        .navigationTitle("Critique")
        .padding()
        .popover(isPresented: $wordTapped,
                 attachmentAnchor: .point(.bottom),
                 arrowEdge: .trailing) {
            VStack {
                ScrollView {
                    Text("Paragraph:").bold().frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 8)
                    Text(paragraphs[instance]).frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                ErrorText(errorMessage: errorMessagePopup)
                QuestionSection(text: "Comment:", response: $comment)
                StretchedButton(text: "Comment!", action: {
                    if comment == "" {
                        errorMessagePopup = "Write comment below."
                    } else {
                        wordTapped = false
                        comments[instance] = comment
                        comment = ""
                        errorMessagePopup = ""
                    }
                })
            }.padding()
        }.alert("Something went wrong!", isPresented: $showingError) {
            Button("OK", role: .cancel) { }
        }
    }
}
