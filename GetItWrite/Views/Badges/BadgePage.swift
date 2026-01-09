//
//  BadgePage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 21/10/2025.
//

import SwiftUI

struct BadgePage: View {
    @State var badges: [Badge]?
    
    var body: some View {
        VStack {
            TitleAndSubtitle(title: "Messing")
            HStack {
                AnyView(getBadge(for: "games played"))
                AnyView(getBadge(for: "games played"))
                AnyView(getBadge(for: "games played"))
                
            }
            TitleAndSubtitle(title: "Plotting")
            TitleAndSubtitle(title: "Drafting")
            TitleAndSubtitle(title: "Editing")
            TitleAndSubtitle(title: "Critiquing")
            TitleAndSubtitle(title: "Querying")
            TitleAndSubtitle(title: "Authoring")
        }
        .onAppear {
            if let data = UserDefaults.standard.data(forKey: UserDefaultNames.badges.rawValue) {
                if let decoded = try? JSONDecoder().decode([Badge].self, from: data) {
                    badges = decoded
                }
            }
        }
    }
    
    func getBadge(for title: String) -> any View {
        if let b = badges?.filter({ title == $0.title }).first {
            return BadgeView(badge: b)
        } else {
            return BadgeView(badge: Badge(id: UUID().hashValue, score: 0, title: title))
        }
    }
}
