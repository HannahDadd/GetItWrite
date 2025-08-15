//
//  SignUpView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/02/2022.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    //    @AppStorage("hasntAcceptedTsAndCs") var hasntAcceptedTsAndCs = true
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var session: FirebaseSession
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var confirmPassword: String = ""
    @State private var displayName: String = ""
    
    @State var changePage = false
    @State var showTsAndCs = false
    @State var agreeToTsAndCs = false
    @State var showPP = false
    @State var agreeToPP = false
    @State var agreeOver18 = false
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                Text("Sign Up")
                    .font(Font.custom("AbrilFatface-Regular", size: 34))
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Username", text: $displayName).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Email", text: $email).textFieldStyle(.roundedBorder)
                TextField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Confirm password", text: self.$confirmPassword).textFieldStyle(.roundedBorder)
                Toggle(isOn: $agreeToTsAndCs) {
                    Button(action: { showTsAndCs.toggle() }) {
                        Text("Accept Terms and Conditions")
                            .foregroundColor(Color.primary)
                            .bold()
                    }
                }.tint(Color.primary).padding(.bottom)
                Toggle(isOn: $agreeToPP) {
                    Button(action: { showPP.toggle() }) {
                        Text("Accept Privacy Policy")
                            .foregroundColor(Color.primary)
                            .bold()
                    }
                }.tint(Color.primary).padding(.bottom)
                Toggle(isOn: $agreeOver18) {
                    Text("I am over 18")
                        .foregroundColor(Color.primary)
                        .bold()
                }.tint(Color.primary).padding(.bottom)
            }
            Text(errorMessage)
                .foregroundColor(Color.red)
                .fixedSize(horizontal: false, vertical: true)
            StretchedButton(text: "SIGN UP", action: signUp)
            Button(action: { presentation.wrappedValue.dismiss() }) {
                Text("Back to Login")
                    .foregroundColor(Color.primary)
                    .bold()
                NavigationLink(destination: OnboardingPageOne(displayName: displayName).environmentObject(session), isActive: self.$changePage) {
                    EmptyView()
                }
            }
        }
        .padding()
        .navigationBarHidden(true)
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
        } else if displayName.isEmpty {
            errorMessage = "Please provide a username"
        } else if password == confirmPassword {
            //hasntAcceptedTsAndCs = false
            session.signUp(email: email, password: password) { (result, error) in
                if let error = error {
                    errorMessage = error.localizedDescription
                } else {
                    session.updateUser(
                        newUser: User(
                            id: session.user?.uid ?? "Error",
                            displayName: displayName,
                            bio: "",
                            photoURL: "",
                            writing: "",
                            authors: [],
                            writingGenres: [],
                            colour: Int.random(in: 0..<GlobalVariables.profileColours.count),
                            rating: 3,
                            critiqueStyle: "",
                            blockedUserIds: [],
                            lastCritique: nil,
                            lastFiveCritiques: [],
                            frequencey: 0.0,
                            critiquerExpected: ""
                        ))
                    changePage = true
                }
            }
        } else {
            errorMessage = "Passwords do not match"
        }
    }
}
