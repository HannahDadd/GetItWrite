//
//  LoginView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/02/2022.
//

import SwiftUI
import UIKit

struct LoginView: View {
    @EnvironmentObject var session: FirebaseSession
    
    @State var email: String = ""
    @State var password: String = ""
    @State private var errorMessage: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Sitting").resizable().aspectRatio(contentMode: .fit)
                Text("Login").font(.largeTitle).bold().frame(maxWidth: .infinity, alignment: .leading)
                VStack {
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .textFieldStyle(.roundedBorder)
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .textFieldStyle(.roundedBorder)
                    Button(action: resetPassword) {
                        Text("Forgot password?").foregroundColor(Color.lightBackground).bold()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                StretchedButton(text: "LOGIN", action: logIn)
                ErrorText(errorMessage: errorMessage)
                Spacer()
                NavigationLink(destination: SignUpView()) {
                    Text("Don't have an account? Sign Up")
                        .foregroundColor(Color.lightBackground).bold()
                }
            }.padding().navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle()).accentColor(Color.darkText)
    }
    
    func logIn() {
        self.session.logIn(email: email, password: password) { (result, error) in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    func resetPassword() {
        self.session.resetPassword(email: email) { (error) in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
                errorMessage = "Password reset email sent."
            }
        }
    }
}
