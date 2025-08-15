//
//  ForgotPasswordView.swift
//  Get It Write
//
//  Created by Hannah Billingsley-Dadd on 19/07/2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    @EnvironmentObject var session: FirebaseSession
    @State var email: String = ""
    @State private var errorMessage: String = ""
    @State private var successAlert = false

    var body: some View {
        VStack {
            Image("Sitting").resizable().aspectRatio(contentMode: .fit)
            Text("Reset Password").font(.largeTitle).bold().frame(maxWidth: .infinity, alignment: .leading)
            TextField("Account Email", text: $email).textFieldStyle(RoundedBorderTextFieldStyle())
            StretchedButton(text: "Reset Password", action: resetPassword)
            ErrorText(errorMessage: errorMessage)
            Spacer()
            NavigationLink(destination: LoginView().environmentObject(session)) {
                Text("Back to Login")
                    .foregroundColor(Color.primary).bold()
            }
        }.alert("Password Successfully Reset!", isPresented: $successAlert) {
            Button("OK", role: .cancel) { }
        }
        .padding().navigationBarHidden(true)
    }
    
    func resetPassword() {
        self.session.resetPassword(email: email) { (error) in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                successAlert = true
            }
        }
    }
}
