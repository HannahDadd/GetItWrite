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
                AnyView(getBadge(for: BadgeTitles.gamesPlayed.rawValue))
                AnyView(getBadge(for: BadgeTitles.prompsUsed.rawValue))
                AnyView(getBadge(for: BadgeTitles.wordsLearnt.rawValue))
            }
            TitleAndSubtitle(title: "Plotting")
            HStack {
                AnyView(getBadge(for: BadgeTitles.moodBoards.rawValue))
                AnyView(getBadge(for: BadgeTitles.characterProfiles.rawValue))
            }
            TitleAndSubtitle(title: "Drafting")
            HStack {
                AnyView(getBadge(for: BadgeTitles.chaptersWritten.rawValue))
                AnyView(getBadge(for: BadgeTitles.wordsWritten.rawValue))
                AnyView(getBadge(for: BadgeTitles.draftsWritten.rawValue))
            }
            TitleAndSubtitle(title: "Editing")
            HStack {
                AnyView(getBadge(for: BadgeTitles.chaptersEdited.rawValue))
                AnyView(getBadge(for: BadgeTitles.draftsEdited.rawValue))
            }
            TitleAndSubtitle(title: "Critiquing")
            HStack {
                AnyView(getBadge(for: BadgeTitles.critiquePartners.rawValue))
                AnyView(getBadge(for: BadgeTitles.manuscriptReviewed.rawValue))
                AnyView(getBadge(for: BadgeTitles.feedbackRounds.rawValue))
            }
            TitleAndSubtitle(title: "Querying")
            HStack {
                AnyView(getBadge(for: BadgeTitles.queriesSent.rawValue))
                AnyView(getBadge(for: BadgeTitles.fullRequest.rawValue))
                AnyView(getBadge(for: BadgeTitles.offersOfRep.rawValue))
            }
            TitleAndSubtitle(title: "Authoring")
            HStack {
                AnyView(getBadge(for: BadgeTitles.booksPublished.rawValue))
                AnyView(getBadge(for: BadgeTitles.awardWon.rawValue))
            }
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

enum BadgeTitles:String {
    case gamesPlayed = "games played"
    case prompsUsed = "prompts used"
    case wordsLearnt = "words learnt"
    case moodBoards = "mood boards"
    case characterProfiles = "character profiles"
    case wordsWritten = "words written"
    case chaptersWritten = "chapters written"
    case draftsWritten = "drafts written"
    case chaptersEdited = "chapters edited"
    case draftsEdited = "drafts edited"
    case critiquePartners = "critique partners"
    case manuscriptReviewed = "manuscript reviewed"
    case feedbackRounds = "feedback rounds"
    case queriesSent = "queries sent"
    case fullRequest = "full request"
    case offersOfRep = "offers of rep"
    case booksPublished = "books published"
    case awardWon = "award won"
}
