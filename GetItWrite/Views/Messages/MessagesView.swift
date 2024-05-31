//
//  MessagesView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 22/05/2022.
//

import SwiftUI

struct MessagesView: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var result: Result<(String, [Message]), Error>?
    @State var message: String = ""
    @State var showMakeCritiqueView = false
    
    let user2Id: String
    let user2Username: String
    
    var body: some View {
        switch result {
        case .success(let chatDetails):
            ScrollViewReader { value in
                VStack {
                    if chatDetails.1.count == 0 {
                        VStack {
                            Text("No messages yet").font(.caption)
                        }
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(chatDetails.1, id: \.id) { m in
                                if m.senderID == session.userData?.id {
                                    SelfChatBubble(message: m).id(chatDetails.1.firstIndex(of: m))
                                } else {
                                    OtherUserChatBubble(message: m).id(chatDetails.1.firstIndex(of: m))
                                }
                            }.onChange(of: chatDetails.1.count) { count in
                                withAnimation {
                                    value.scrollTo(count - 1)
                                }
                            }.onAppear {
                                value.scrollTo((chatDetails.1.count-1))
                            }
                        }
                    }
                    Spacer()
                    VStack {
                        StretchedButton(text: "Send work to \(user2Username)", action: { self.showMakeCritiqueView.toggle() })
                            .padding(.horizontal)
                        SendBar(text: $message, onSend: {
                            session.sendMessage(content: message, chatId: chatDetails.0)
                        })
                    }
                }
            }
            .navigationBarTitle(Text(user2Username), displayMode: .inline)
            .sheet(isPresented: self.$showMakeCritiqueView) {
                MakeTextView(showMakeCritiqueView: self.$showMakeCritiqueView, chatId: chatDetails.0, userId: user2Id, displayName2: user2Username).environmentObject(session)
            }
        case .failure(let error):
            ErrorView(error: error, retryHandler: loadMessages)
        case nil:
            ProgressView().onAppear(perform: loadMessages)
        }
    }
    
    private func loadMessages() {
        session.loadChat(user2UID: user2Id) {
            result = $0
        }
    }
}
