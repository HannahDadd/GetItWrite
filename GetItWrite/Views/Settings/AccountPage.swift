//
//  AccountPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 17/02/2026.
//

import SwiftUI

struct AccountPage: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Privacy Policy", destination: PrivacyPolicy())
                NavigationLink("Terms of Service", destination: TsAndCsView())
                VStack(alignment: .leading, spacing: 8) {
                    Text("Want to contact us?")
                    Text("Email: getitwrite@gmail.com")
                }
            }
            .listStyle(.insetGrouped)
            .navigationBarTitle("Settings")
        }
    }
}
