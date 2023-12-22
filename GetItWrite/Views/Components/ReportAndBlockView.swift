//
//  ReportAndBlockView.swift
//  Get It Write
//
//  Created by Hannah Dadd on 22/12/2023.
//

import SwiftUI

struct ReportAndBlockView: View {
    @EnvironmentObject var session: FirebaseSession
    @State var showReportContentSheet = false
    @State var showBlockUserPopUp = false
    @State private var notes = ""
    @State private var errorMessage = ""
    @State private var showConfirmation = false
    @State private var showConfirmationBlock = false
    
    let content: UserGeneratedContent
    let contentType: DatabaseNames
    let toBeBlockedUserId: String
    
    var body : some View {
        HStack() {
            Button(action: { showBlockUserPopUp = true }) {
                Text("Block User").bold()
            }
            Button(action: { showReportContentSheet = true }) {
                Image(systemName: "flag").imageScale(.large).foregroundColor(Color.lightBackground)
                Text("Report Content")
            }
        }
        .foregroundColor(.red)
        .sheet(isPresented: $showReportContentSheet) {
            VStack {
                QuestionSection(text: "Would you like to add any notes about the content you are reporting? The content will be reviewed and appropriate action will be taken, which can include deleting the perpetrators account.", response: $notes)
                Spacer()
                ErrorText(errorMessage: errorMessage)
                StretchedButton(text: "Report", action: {
                    session.reportContent(content: content, message: notes, contentType: contentType, completion: { err in
                        if err != nil {
                            showReportContentSheet = false
                            showConfirmation = true
                        } else {
                            errorMessage = "Something went wrong. Try again."
                        }
                    })
                })
            }
        }
        .alert("Are you sure you want to block this user? You cannot undo this.", isPresented: $showBlockUserPopUp, actions: {
            Button("Block User", role: .destructive, action: {
                guard let user = session.userData else { return }
                user.blockedUserIds.append(toBeBlockedUserId)
                session.updateUser(newUser: User(id: session.user?.uid ?? "Error", displayName: user.displayName, bio: user.bio, photoURL: "", writing: user.writing, authors: user.authors, writingGenres: user.writingGenres, colour: user.colour, rating: user.rating, critiqueStyle: user.critiqueStyle, blockedUserIds: user.blockedUserIds))
            })
        })
        .alert("This content has been reported. You will no longer see this content after refreshing the app.", isPresented: $showConfirmation, actions: {})
        .alert("This user has been blocked. You will no longer see their proposals, messages or critiques.", isPresented: $showConfirmationBlock, actions: {})
    }
}
