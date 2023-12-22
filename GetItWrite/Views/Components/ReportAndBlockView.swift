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
    @State private var notes: String = ""
    
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
                QuestionSection(text: "Would you like to add any notes about the content you are reporting?", response: $notes)
                Spacer()
                StretchedButton(text: "Report", action: {
                })
            }
        }
        .alert("Are you sure you want to block this user?", isPresented: $showBlockUserPopUp, actions: {
            Button("Destructive", role: .destructive, action: {})
        })
    }
}
