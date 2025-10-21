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
        VStack(alignment: .leading) {
            HeadlineAndSubtitle(title: "Celebrate your Wins", subtitle: "Writing games to keep you on top form.")
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    VStack(alignment: .leading, spacing: 12) {
                        Title(title: "Messing")
                        HStack() {
                            AnyView(getBadge(for: BadgeTitles.gamesPlayed.rawValue))
                            AnyView(getBadge(for: BadgeTitles.prompsUsed.rawValue))
                            AnyView(getBadge(for: BadgeTitles.wordsLearnt.rawValue))
                        }
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        Title(title: "Writing")
                        HStack {
                            AnyView(getBadge(for: BadgeTitles.wordsWritten.rawValue))
                            AnyView(getBadge(for: BadgeTitles.projects.rawValue))
                        }
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        Title(title: "Querying")
                        HStack {
                            AnyView(getBadge(for: BadgeTitles.queriesSent.rawValue))
                            AnyView(getBadge(for: BadgeTitles.fullRequest.rawValue))
                        }
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        Title(title: "Authoring")
                        HStack {
                            AnyView(getBadge(for: BadgeTitles.booksPublished.rawValue))
                        }
                    }
                    VStack {
                        EmptyView()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding()
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

enum BadgeTitles:String {
    case gamesPlayed = "games played"
    case prompsUsed = "prompts used"
    case wordsLearnt = "words learnt"
    case wordsWritten = "words written"
    case projects = "projects"
    case chaptersEdited = "chapters edited"
    case critiquePartners = "critique partners"
    case feedbackRounds = "feedback rounds"
    case queriesSent = "queries sent"
    case fullRequest = "full request"
    case booksPublished = "books published"
}
