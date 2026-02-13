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
        HStack(spacing: 25) {
            Image(systemName: achevied ? imageName : "")
                .foregroundColor(.white)
                .padding(10)
                .background(achevied ? Color.toneCard : Color.gray)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(title)
                    .multilineTextAlignment(.leading)
                    .font(Font.custom("Bellefair-Regular", size: 18))
                if !subtitle.isEmpty {
                    Spacer()
                    Text(subtitle)
                        .multilineTextAlignment(.leading)
                }
                VStack {
                    EmptyView()
                }
                .frame(maxWidth: .infinity)
            }
            Spacer()
            if achevied {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(Color.toneCard)
            } else {
                Image(systemName: "lock.fill")
                    .foregroundStyle(.gray)
            }
        }
        //        .padding()
        //        .frame(maxWidth: .infinity)
        //        .frame(height: 100)
        //        .cornerRadius(8)
    }
}
