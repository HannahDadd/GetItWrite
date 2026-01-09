//
//  SprintCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 15/08/2025.
//

import SwiftUI

struct SoloSprintCTA: View {
    var action: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                Image(.sprintPromo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15)
                VStack(alignment: .leading) {
                    Spacer()
                    Text("Unleash your productivity.")
                        .font(.title3)
                        .foregroundColor(.black)
                        .padding()
                        .background(.white)
                        .multilineTextAlignment(.leading)
                        .cornerRadius(15)
                    Spacer()
                }
            }
            StretchedButton(text: "Start a Writing Sprint", action: action)
                .cornerRadius(15)
        }
    }
}
