//
//  BadgePromo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 12/02/2026.
//

import SwiftUI

struct BadgePromo: View {
    @AppStorage var achevied: Bool
    var title: String
    var imageName: String
    
    init(title: String, imageName: String, userDefaultName: String) {
        self.title = title
        self.imageName = imageName
        _achevied = AppStorage(wrappedValue: false, userDefaultName)
    }
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: achevied ? imageName : "")
                .foregroundColor(.white)
                .padding(10)
                .background(achevied ? Color.toneCard : Color.gray)
                .clipShape(Circle())
            Text(title)
                .multilineTextAlignment(.leading)
                .font(Font.custom("Bellefair-Regular", size: 18))
            Spacer()
            if achevied {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(Color.toneCard)
            } else {
                Image(systemName: "lock.fill")
                    .foregroundStyle(.gray)
            }
        }
        .padding(.vertical)
    }
}
