//
//  CTAGoal.swift
//  Get It Write
//
//  Created by Hannah Dadd on 28/07/2025.
//

import SwiftUI

struct WIPsCTA: View {
    @State var WIPs: [WIP] = []
    @State var createWIP = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            HStack {
                Text("Your WIPs")
                    .font(.title)
                    .onAppear {
                        if let data = UserDefaults.standard.data(forKey: UserDefaultNames.wips.rawValue) {
                            if let decoded = try? JSONDecoder().decode([WIP].self, from: data) {
                                WIPs = decoded
                            }
                        }
                    }
                Spacer()
                Image(systemName: "plus.app.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.primary)
                    .onTapGesture {
                        createWIP = true
                    }
            }
            if WIPs.isEmpty {
                Text("Add your writing projects here.")
            }
            Divider()
            ForEach(WIPs, id: \.id) { w in
                WIPView(w: w)
            }
        }
        .sheet(isPresented: $createWIP) {
            NewWIP(wips: WIPs, action: { newWIP in
                WIPs = newWIP
                createWIP = false
            })
        }
    }
}
