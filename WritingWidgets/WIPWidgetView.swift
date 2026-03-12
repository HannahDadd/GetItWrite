//
//  WIPView.swift
//  Get It Write
//
//  Created by Hannah Dadd on 12/03/2026.
//

import SwiftUI

struct WIPWidgetView: View {
    let wip: WIP
    let isMediumWidget: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            if wip.count > wip.goal {
                ProgressView(value: 1.0) {
                    Text("\(wip.title)")
                        .font(Font.custom("Bellefair-Regular", size: 16))
                }.tint(.primary)
                Text("You've hit your target workout! This WIP is \(wip.count - wip.goal) words over!")
            } else {
                VStack(alignment: .leading, spacing: 16) {
                    ProgressView(value: Double(wip.count) / Double(wip.goal)) {
                        Text("\(wip.title)")
                            .font(Font.custom("Bellefair-Regular", size: isMediumWidget ? 22 : 16))
                            .padding(.bottom, isMediumWidget ? 8 : 0)
                    }.tint(.primary)
                    VStack(alignment: .leading) {
                        Text("Current: \(wip.count) words")
                            .font(.caption)
                        Text("Goal: \(wip.goal) words")
                            .bold()
                            .font(.caption)
                        Spacer()
                        HStack {
                            Spacer()
                            Text("\(Int((Double(wip.count) / Double(wip.goal)) * 100))% complete")
                                .font(.caption)
                                .padding(6)
                                .foregroundColor(.white)
                                .background(.black)
                                .clipShape(Capsule())
                        }
                    }
                }
            }
        }
    }
}
