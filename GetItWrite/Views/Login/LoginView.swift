//
//  LoginView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/02/2022.
//

import SwiftUI
import UIKit
import GoogleSignIn

struct LoginView: View {

    @State var email: String = ""
    @State var password: String = ""

    @EnvironmentObject var session: FirebaseSession

    var body: some View {

        NavigationView {
            VStack {
                TextField("Email", text: $email).textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {}) { Text("Forgot password?") }
                Button(action: logIn) {
                    Text("LOGIN").bold().font(.system(size: 14))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.black)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 2))
                }.padding()
                Text("- OR -").bold()
                Google()
                NavigationLink(destination: SignUpView()) {
                    Text("Don't have an account? Sign Up")
                }
            }
        }
        .padding()
    }

    func logIn() {
        self.session.logIn(email: email, password: password) { (result, error) in
            if error != nil {
                print(error.debugDescription)
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
}

struct Google: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<Google>) -> GIDSignInButton {
        let button = GIDSignInButton()
//        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        return button
    }

    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<Google>) {
    }
}
