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
                if w.count > w.goal {
                    ProgressView(value: 1.0) {
                        Text("\(w.title)")
                    }.tint(.primary)
                    Text("You've hit your target workout! This WIP is \(w.count - w.goal) words over!")
                } else {
                    VStack(alignment: .leading, spacing: 16) {
                        ProgressView(value: Double(w.count) / Double(w.goal)) {
                            Text("\(w.title)")
                                .font(.headline)
                        }.tint(.primary)
                        VStack(alignment: .leading) {
                            Text("Current: \(w.count) words")
                            Text("Goal: \(w.goal) words")
                                .bold()
                            HStack {
                                Spacer()
                                Text("\(Int((Double(w.count) / Double(w.goal)) * 100))% complete")
                                    .font(.caption)
                                    .padding(6)
                                    .foregroundColor(.onPrimary)
                                    .background(.primary)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    Divider()
                }
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
