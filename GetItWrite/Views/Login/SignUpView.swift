//
//  SignUpView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/02/2022.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var displayName: String = ""

    @EnvironmentObject var session: FirebaseSession

    var body: some View {
        VStack {
            Image("Building").resizable().aspectRatio(contentMode: .fill).padding()
            Text("Sign Up").font(.largeTitle).bold().frame(maxWidth: .infinity, alignment: .leading)
            TextField("Email", text: $email).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Display Name", text: self.$displayName).textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: signUp) {
                Text("SIGN UP").bold()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.darkReadable)
                    .overlay(RoundedRectangle(cornerRadius: 5))
            }.accentColor(Color.clear)
            Text(errorMessage)
                .foregroundColor(Color.red).padding()
        }.padding()
    }

    func signUp() {
        if !email.isEmpty && !password.isEmpty {
            session.signUp(email: email, password: password) { (result, error) in
                if error != nil {
                    if let errCode = AuthErrorCode(rawValue: error!._code) {

                        switch errCode {
                        case .invalidEmail:
                            self.errorMessage = "Invalid Email"
                        case .emailAlreadyInUse:
                            self.errorMessage = "Email already in use"
                        case .missingEmail:
                            self.errorMessage = "Email Field is Required"
                        case .weakPassword:
                            self.errorMessage = "Weak Password, must be 6 Characters"
                        default:
                            self.errorMessage = " User Error: \(error!)"
                        }
                    }
                }
            }
        } else {
            errorMessage = "Please provide an email and password"
        }
    }
}
