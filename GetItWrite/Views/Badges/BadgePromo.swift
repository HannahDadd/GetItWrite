//
//  BadgePromo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 12/02/2026.
//

import SwiftUI

struct BadgePromo: View {
    var title: String
    var subtitle: String
    var imageName: String
    var achevied: Bool
    
    var body: some View {
        Section {
            HStack {
                Image(systemName: imageName)
                VStack(alignment: .leading) {
                    Text(title)
                        .multilineTextAlignment(.leading)
                        .font(Font.custom("Bellefair-Regular", size: 28))
                    Spacer()
                    Text(subtitle)
                        .multilineTextAlignment(.leading)
                    VStack {
                        EmptyView()
                    }
                    .frame(maxWidth: .infinity)
                }
                Spacer()
                if achevied {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                } else {
                    Image(systemName: "lock.fill")
                        .foregroundStyle(.gray)
                }
            }
        }
        .padding()
//        .frame(maxWidth: .infinity)
//        .frame(height: 100)
//        .cornerRadius(8)
    }
}
