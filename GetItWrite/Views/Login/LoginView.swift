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
    @EnvironmentObject var session: FirebaseSession

    @State var email: String = ""
    @State var password: String = ""

    var body: some View {

        NavigationView {
            VStack {
                Image("Sitting").resizable().aspectRatio(contentMode: .fit)
                Spacer()
                Text("Login").font(.largeTitle).bold().frame(maxWidth: .infinity, alignment: .leading)
                TextField("Email", text: $email).textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {}) {
                    Text("Forgot password?").foregroundColor(Color.darkReadable).bold()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                Button(action: logIn) {
                    Text("LOGIN").bold().font(.system(size: 14))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 5))
                        .background(Color.darkReadable)
                }
                Text("- OR -").bold().foregroundColor(Color.darkReadable)
                Google()
                NavigationLink(destination: SignUpView()) {
                    Text("Don't have an account? Sign Up").foregroundColor(Color.darkReadable).bold()
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
