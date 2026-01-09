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
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Your WIPs")
                Spacer()
                Image(systemName: "plus.app.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.primary)
                    .onTapGesture {
                        createWIP = true
                    }
            }
            ForEach(WIPs, id: \.id) { w in
                ProgressView(value: Double(w.count/w.goal)) {
                    Text("\(w.title)")
                }
            }
            .padding()
        }
        .sheet(isPresented: $createWIP) {
            NewWIP(action: {
                createWIP = false
            })
        }
        .onAppear {
            if let data = UserDefaults.standard.data(forKey: UserDefaultNames.wips.rawValue) {
                if let decoded = try? JSONDecoder().decode([WIP].self, from: data) {
                    WIPs = decoded
                }
            }
        }
        .padding()
    }
}
