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
    @State private var showButtons = false
    
    let content: UserGeneratedContent
    let contentType: DatabaseNames
    let toBeBlockedUserId: String
    let imageScale: Image.Scale
    var questionId: String? = nil
    
    var body : some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "info.circle.fill")
                    .imageScale(imageScale)
                    .foregroundColor(imageScale == .small ? .gray : .black)
                    .onTapGesture {
                        showButtons.toggle()
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: imageScale == .large ? 8 : 0))
            }
            if showButtons {
                reportAndBlockButtons
            }
        }
    }
    
    @ViewBuilder
    var reportAndBlockButtons: some View {
        HStack {
            Button(action: { showReportContentSheet = true }) {
                HStack {
                    Image(systemName: "flag").imageScale(.medium)
                    Text("Report Content").font(.caption)
                }
            }
            Spacer()
            if let hasBlockedUser = session.userData?.blockedUserIds.contains(toBeBlockedUserId), hasBlockedUser {
                Text("User blocked.").font(.caption).bold()
            } else {
                Button(action: { showBlockUserPopUp = true }) {
                    Text("Block User").font(.caption).bold()
                }
            }
        }
        .foregroundColor(Color.primary)
        .padding(.vertical)
        .sheet(isPresented: $showReportContentSheet) {
            VStack {
                QuestionSection(text: "Would you like to add any notes about the content you are reporting?", response: $notes)
                Text("The content will be reviewed and appropriate action will be taken, which can include deleting the perpetrators account. Upon refresh, you'll find the content has been removed from the app.").font(.caption)
                Spacer()
                ErrorText(errorMessage: errorMessage)
                StretchedButton(text: "Report", action: {
                    session.reportContent(content: content, message: notes, contentType: contentType, questionId: questionId, completion: { err in
                        if err == nil {
                            showReportContentSheet = false
                            showConfirmation = true
                        } else {
                            errorMessage = "Something went wrong. Try again."
                        }
                    })
                })
            }.padding()
        }
        .alert("Are you sure you want to block this user? You cannot undo this.", isPresented: $showBlockUserPopUp, actions: {
            Button("Block User", role: .destructive, action: {
                guard let user = session.userData else { return }
                if !user.blockedUserIds.contains(toBeBlockedUserId) {
                    user.blockedUserIds.append(toBeBlockedUserId)
                    session.updateUser(blockedUserIds: user.blockedUserIds)
                }
            })
        })
        .alert("This content has been reported. You will no longer see this content after restarting the app.", isPresented: $showConfirmation, actions: {})
        .alert("This user has been blocked. You will no longer see their messages.", isPresented: $showConfirmationBlock, actions: {})
    }
}
