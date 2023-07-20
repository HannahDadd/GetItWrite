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
    @State var showTsAndCs = false
    @State var agreeToTsAndCs = false
    @State var showPP = false
    @State var agreeToPP = false
    @State var agreeOver18 = false
    
    var body: some View {
        VStack {
            Image("Building").resizable().aspectRatio(contentMode: .fit).padding()
            Group {
                Text("Sign Up").font(.largeTitle).bold().frame(maxWidth: .infinity, alignment: .leading)
                TextField("Email", text: $email).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Confirm password", text: self.$confirmPassword).textFieldStyle(RoundedBorderTextFieldStyle())
                Toggle(isOn: $agreeToTsAndCs) {
                    Button(action: { showTsAndCs.toggle() }) {
                        Text("Accept Terms and Conditions").foregroundColor(Color.lightBackground).bold()
                    }
                }.tint(.lightBackground).padding(.bottom)
                Toggle(isOn: $agreeToPP) {
                    Button(action: { showPP.toggle() }) {
                        Text("Accept Privacy Policy").foregroundColor(Color.lightBackground).bold()
                    }
                }.tint(.lightBackground).padding(.bottom)
                Toggle(isOn: $agreeOver18) {
                    Text("I am over 18").foregroundColor(Color.lightBackground).bold()
                }.tint(.lightBackground).padding(.bottom)
            }
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
            .sheet(isPresented: self.$showTsAndCs) {
                TsAndCsView()
            }
            .sheet(isPresented: self.$showPP) {
                PrivacyPolicyView()
            }
    }
    
    func signUp() {
        if !agreeToTsAndCs {
            errorMessage = "Please accept the Terms and Conditions"
        } else if !agreeOver18 {
            errorMessage = "You must be over 18 to use this app."
        } else if !agreeToPP {
            errorMessage = "Please accept the privacy policy."
        } else if email.isEmpty || password.isEmpty {
            errorMessage = "Please provide an email and password"
        } else if password == confirmPassword {
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
    }
}
