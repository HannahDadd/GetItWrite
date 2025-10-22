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
                        HStack(spacing: 8) {
                            AnyView(getBadge(for: BadgeTitles.gamesPlayed.rawValue))
                            AnyView(getBadge(for: BadgeTitles.prompsUsed.rawValue))
                            AnyView(getBadge(for: BadgeTitles.wordsLearnt.rawValue))
                        }
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        Title(title: "Writing")
                        HStack(spacing: 8) {
                            AnyView(getBadge(for: BadgeTitles.wordsWritten.rawValue))
                            AnyView(getBadge(for: BadgeTitles.projects.rawValue))
                        }
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        Title(title: "Querying")
                        HStack(spacing: 8) {
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
                    HStack {
                        Circle()
                            .fill(Color.badgeBg)
                            .frame(width: 25, height: 25)
                        Text("tap to increment, double tap to reset")
                    }
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
        let text = popUpText(badgeName: title)
        let popUp = popUpButton(badgeName: title)
        if let b = badges?.filter({ title == $0.title }).first {
            return BadgeView(badge: b, onTapText: text, shouldShowPopup: popUp)
        } else {
            return BadgeView(badge: Badge(id: UUID().hashValue, score: 0, title: title), onTapText: text, shouldShowPopup: popUp)
        }
    }
    
    func popUpText(badgeName: BadgeTitles.RawValue) -> String {
        let enumValue = BadgeTitles(rawValue: badgeName)
        switch enumValue {
        case .gamesPlayed:
            return "Head over to the writing games tab to improve your skills."
        case .prompsUsed:
            return "Use the writing prompts to create short stories."
        case .wordsLearnt:
            return "Learn new words in the vocab checker."
        case .wordsWritten:
            return "Add words to a project."
        case .projects:
            return "Create WIPs in the app to track them."
        case .queriesSent:
            return "Sent of some queries? Congrats! Add them here."
        case .fullRequest:
            return "Received a full request? What a pro!"
        case .booksPublished:
            return "You're on to a winner with that one."
        case .none:
            return ""
        }
    }
    
    func popUpButton(badgeName: BadgeTitles.RawValue) -> Bool {
        let enumValue = BadgeTitles(rawValue: badgeName)
        switch enumValue {
        case .gamesPlayed, .prompsUsed, .wordsLearnt, .wordsWritten, .projects, .none:
            return true
        case .queriesSent, .fullRequest, .booksPublished:
            return false
        }
    }
}

enum BadgeTitles:String {
    case gamesPlayed = "games played"
    case prompsUsed = "prompts used"
    case wordsLearnt = "words learnt"
    case wordsWritten = "words written"
    case projects = "projects"
    case queriesSent = "queries sent"
    case fullRequest = "full request"
    case booksPublished = "books published"
}
