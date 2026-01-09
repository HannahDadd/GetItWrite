//
//  CTAGoal.swift
//  Get It Write
//
//  Created by Hannah Dadd on 28/07/2025.
//

import SwiftUI

struct WIPView: View {
    let w: WIP
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
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
}
