//
//  TallyCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 22/10/2025.
//

import SwiftUI

struct TallyCTA: View {
    @AppStorage(UserDefaultNames.tally.rawValue) private var tally = 0
    var action: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Spacer()
                Text("\(tally)")
                    .font(Font.custom("AbrilFatface-Regular", size: 44))
                    .padding()
                    .foregroundColor(.onPrimary)
                    .background(.primary)
                    .clipShape(Capsule())
                Spacer()
            }
            Text("words you've written on the app.")
                .font(Font.custom("Bellefair-Regular", size: 18))
            //GameButton(text: "Add Words to a Project", action: action)
        }
    }
}
