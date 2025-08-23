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
                Text("Let's get your writing projects on the way.")
            }
            ForEach(WIPs, id: \.id) { w in
                ProgressView(value: Double(w.count/w.goal)) {
                    Text("\(w.title)")
                }
            }
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
    }
}
