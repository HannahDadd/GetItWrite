//
//  BadgePage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 21/10/2025.
//

import SwiftUI

struct BadgePage: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            HeadlineAndSubtitle(title: "Your Progress", subtitle: "Writing games to keep you on top form.")
            Text("Your goal:")
                .font(Font.custom("Bellefair-Regular", size: 24))
            
            VStack(spacing: 16) {
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                
                SDiagonalPath()
                    .stroke(
                        Color.black,
                        style: StrokeStyle(
                            lineWidth: 3,
                            lineCap: .round,
                            dash: [5, 8]
                        )
                    )
                    .frame(height: 200)
                    .padding()
                
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            .padding()
            //            ScrollView {
            //                VStack {
            //
            //                }
            //            }
        }
        .padding()
    }
}
