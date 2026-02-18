//
//  FinishBookPromo.swift
//  Get It Write
//
//  Created by Hannah Dadd on 16/02/2026.
//

import SwiftUI

struct FinishBookPromo: View {
    @AppStorage var achevied: Bool
    let badge: Badge
    
    init(badge: Badge) {
        self.badge = badge
        _achevied = AppStorage(wrappedValue: false, badge.rawValue)
    }
    
    var body: some View {
        HStack {
            Image(systemName: "trophy.fill")
                .imageScale(.large)
                .foregroundColor(.white)
                .padding(10)
                .background(achevied ? Color.goldAchieve : Color.gray)
                .clipShape(Circle())
            Text(badge.getText())
                .font(Font.custom("Bellefair-Regular", size: 18))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
    }
}
