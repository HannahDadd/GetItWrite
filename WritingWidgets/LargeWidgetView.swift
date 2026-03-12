//
//  LargeWidgetView.swift
//  Get It Write
//
//  Created by Hannah Dadd on 11/03/2026.
//

import SwiftUI

struct LargeWidgetView: View {
    let entry: GetItWriteEntry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ProgressView(value: Double(entry.wordCount) / Double(entry.targetWordCount)) {
                Text("\(entry.bookname)")
                    .font(Font.custom("Bellefair-Regular", size: 22))
            }.tint(.primary)
            VStack(alignment: .leading) {
                Text("Current: \(entry.wordCount) words")
                Text("Goal: \(entry.targetWordCount) words")
                    .bold()
                HStack {
                    Spacer()
                    Text("\(Int((Double(entry.wordCount) / Double(entry.targetWordCount)) * 100))% complete")
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
