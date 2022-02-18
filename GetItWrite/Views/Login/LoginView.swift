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
    @State private var errorMessage: String = ""

    var body: some View {
        VStack {
            Image("Sitting").resizable().aspectRatio(contentMode: .fill).padding()
            Text("Login").font(.largeTitle).bold().frame(maxWidth: .infinity, alignment: .leading)
            VStack {
                TextField("Email", text: $email).textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {}) {
                    Text("Forgot password?").foregroundColor(Color.darkReadable).bold()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                Text(errorMessage).foregroundColor(Color.red).fixedSize(horizontal: false, vertical: true)
            }
            Button(action: logIn) {
                Text("LOGIN").bold()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.darkReadable)
                    .overlay(RoundedRectangle(cornerRadius: 5))
            }.accentColor(Color.clear)
            Text("- OR -").bold().font(.caption).foregroundColor(Color.darkReadable)
            Google()
            Spacer()
            NavigationLink(destination: SignUpView()) {
                Text("Don't have an account? Sign Up").foregroundColor(Color.darkReadable).bold()
            }
        }.padding().navigationBarHidden(true)
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
