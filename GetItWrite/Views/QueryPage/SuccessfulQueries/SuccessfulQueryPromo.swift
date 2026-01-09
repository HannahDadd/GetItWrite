//
//  SuccessfulQueryPromo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 28/01/2025.
//

import SwiftUI

struct SuccessfulQueryPromo: View {
    @State var showPopUp = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Has your query letter seen success?")
                .multilineTextAlignment(.leading)
                .font(.headline)
                .foregroundColor(Color.onSecondary)
            Spacer()
            Text("Consider sharing it here to inspire other writers!")
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .font(.subheadline)
                .foregroundColor(Color.onSecondary)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(Color.secondary)
        .cornerRadius(8)
        .onTapGesture { showPopUp = true }
        .shadow(radius: 5)
        .padding()
        .sheet(isPresented: self.$showPopUp) {
            CreateSuccessfulQuery(showPopUp: self.$showPopUp)
        }
    }
}
