//
//  CreateCritiqueFrenzy.swift
//  Get It Write
//
//  Created by Hannah Billingsley-Dadd on 16/04/2024.
//

import SwiftUI
import UserNotifications

struct CreateCritiqueFrenzy: View {
    @EnvironmentObject var session: FirebaseSession

    @State private var text: String = ""
    @State private var errorMessage: String = ""
    @State var genres: [String] = []
    @Binding var showMakeCritiqueView: Bool
    
    let isQueries: Bool

    var body: some View {
        VStack {
            Text("Make \(isQueries ? "Query" : "Critique") Frenzy")
                .font(.title)
                .padding(.bottom, 16)
            SelectTagView(chosenTags: $genres, questionLabel: "Select genre:", array: GlobalVariables.genres)
            Text("Add text here:").bold().frame(maxWidth: .infinity, alignment: .leading)
            TextEditor(text: $text)
            ErrorText(errorMessage: errorMessage)
            StretchedButton(text: "Request Critique", action: {
                if let error = CheckInput.isStringGood(text, 1000) {
                    errorMessage = error
                } else {
                    session.newCritiqueFrenzy(isQueries: isQueries, text: text, genres: genres) { err in
                        if let err {
                            errorMessage = "Whoops something went wrong! Try again later. Error message: \(err.localizedDescription)"
                        } else {
                            showMakeCritiqueView.toggle()
                            
                            // Schedule notification
                            let content = UNMutableNotificationContent()
                            content.title = "You posted your \(isQueries ? "query" : "work") 3 days ago."
                            content.subtitle = "Take a look at any feedback you've got."
                            content.sound = UNNotificationSound.default

                            // show this notification five seconds from now
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 259200, repeats: false)
                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                            UNUserNotificationCenter.current().add(request)
                        }
                    }
                }
            })
        }.padding()
    }
}
