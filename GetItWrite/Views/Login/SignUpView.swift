//
//  SignUpView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/02/2022.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var session: FirebaseSession

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var confirmPassword: String = ""

    @State var changePage = false

    var body: some View {
        VStack {
            Image("Building").resizable().aspectRatio(contentMode: .fit).padding()
            Text("Sign Up").font(.largeTitle).bold().frame(maxWidth: .infinity, alignment: .leading)
            TextField("Email", text: $email).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Confirm password", text: self.$confirmPassword).textFieldStyle(RoundedBorderTextFieldStyle())
            StretchedButton(text: "SIGN UP", action: signUp)
            Text(errorMessage).foregroundColor(Color.red).fixedSize(horizontal: false, vertical: true)
            Spacer()
            Button(action: { presentation.wrappedValue.dismiss() }) {
                Text("Back to Login").foregroundColor(Color.lightBackground).bold()
            }
            NavigationLink(destination: CreateAccountView().environmentObject(session), isActive: self.$changePage) {
                 EmptyView()
            }
        }.padding().navigationBarHidden(true)
    }

    func signUp() {
        if !email.isEmpty && !password.isEmpty {
            if password == confirmPassword {
                session.signUp(email: email, password: password) { (result, error) in
                    if let error = error {
                        errorMessage = error.localizedDescription
                    } else {
                        changePage = true
                    }
                }
            } else {
                errorMessage = "Passwords do not match"
            }
        } else {
            errorMessage = "Please provide an email and password"
        }
    }
}
