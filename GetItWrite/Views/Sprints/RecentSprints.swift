//
//  RecentSprints.swift
//  Get It Write
//
//  Created by Hannah Dadd on 14/02/2026.
//

import SwiftUI

struct RecentSprints: View {
    @State var sprints: [PastSoloSprint] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            if !sprints.isEmpty {
                Text("Most recent sprint word counts")
                    .textCase(.uppercase)
            }
            ForEach(sprints, id: \.self) { s in
                HStack {
                    Text(s.name)
                        .font(Font.custom("Bellfair-Regular", size: 20))
                    Spacer()
                    Text("\(s.words) words written")
                        .font(Font.custom("Bellfair-Regular", size: 20))
                }
                Divider()
            }
            VStack {
                EmptyView()
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .onAppear {
            if let data = UserDefaults.standard.data(forKey: UserDefaultNames.pastSoloSprints.rawValue) {
                if let decoded = try? JSONDecoder().decode([PastSoloSprint].self, from: data) {
                    sprints.append(contentsOf: decoded)
                }
            }
        }
    }
}
