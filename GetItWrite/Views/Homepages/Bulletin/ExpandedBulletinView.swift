//
//  ExpandedBulletinView.swift
//  Get It Write
//
//  Created by Hannah Dadd on 28/01/2025.
//

import SwiftUI
import FirebaseFirestore

struct ExpandedBulletinView: View {
    @EnvironmentObject var session: FirebaseSession
    
    @State private var message = "Hello 👋 I'm interested in swapping critiques."
    @State private var sendMessagePopup = false
    
    let b: Bulletin

    var body: some View {
        ZStack {
            ScrollView {
                Text(b.writerName)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 16)
                Text(b.text).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 8)
                Spacer()
                Divider()
                ReportAndBlockView(content: b, contentType: .bulletin, toBeBlockedUserId: b.writerId, imageScale: .large)
            }
            VStack {
                Spacer()
                if b.writerId == session.user?.uid {
                    StretchedButton(text: "This is your work.", action: {}, isActive: false)
                } else if let hasBlockedUser = session.userData?.blockedUserIds.contains(b.writerId), hasBlockedUser {
                    StretchedButton(text: "You blocked this user.", action: {}, isActive: false)
                } else {
                    StretchedButton(text: "Send Message", action: {
                        sendMessagePopup.toggle()
                    })
                }
            }
        }
        .padding()
        .sheet(isPresented: self.$sendMessagePopup) {
            NavigationView {
                MessagesView(message: "Hello 👋 I'm interested in swapping critiques for your project.", user2Id: b.writerId, user2Username: b.writerName).environmentObject(session)
            }
        }

    }
}
