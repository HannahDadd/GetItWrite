//
//  SelectWip.swift
//  Get It Write
//
//  Created by Hannah Dadd on 23/08/2025.
//

import SwiftUI

struct SelectWip: View {
    @State var WIPs: [WIP] = []
    var action: (WIP) -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Your WIPs")
                .font(Font.custom("AbrilFatface-Regular", size: 34))
                .onAppear {
                    if let data = UserDefaults.standard.data(forKey: UserDefaultNames.wips.rawValue) {
                        if let decoded = try? JSONDecoder().decode([WIP].self, from: data) {
                            WIPs = decoded
                        }
                    }
                }
            ScrollView {
                ForEach(WIPs, id: \.id) { w in
                    WIPView(w: w)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            action(w)
                        }
                }
            }
        }
        .padding()
    }
}
