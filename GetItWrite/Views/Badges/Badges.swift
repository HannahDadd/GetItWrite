//
//  Badges.swift
//  Get It Write
//
//  Created by Hannah Dadd on 15/02/2026.
//

import Foundation

enum Badge: String {

    // Badges
    case twentySprint = "twentySprint"
    case fortySprint = "fortySprint"
    case hourSprint = "hourSprint"
    
    case wordNerd200 = "wordNerd200"
    case wordNerd500 = "wordNerd500"
    case wordNerd1000 = "wordNerd1000"
    case wordNerd10000 = "wordNerd10000"
    case wordNerd20000 = "wordNerd20000"
    case wordNerd50000 = "wordNerd50000"
    
    case streakFreak2 = "streakFreak2"
    case streakFreak7 = "streakFreak7"
    case streakFreak14 = "streakFreak14"
    case streakFreak31 = "streakFreak31"
    case streakFreak100 = "streakFreak100"
    
    case quickWords250 = "quickWords250"
    case quickWords500 = "quickWords500"
    case quickWords1000 = "quickWords1000"
    case quickWords2000 = "quickWords2000"
    case quickWords5000 = "quickWords5000"
    
    case bookGoal = "bookGoal"
    
    func getImage() -> String {
        switch self {
        case .twentySprint:
            "bolt.fill"
        case .fortySprint:
            "cup.and.heat.waves.fill"
        case .hourSprint:
            "clock.fill"
        case .wordNerd200, .wordNerd500, .wordNerd1000, .wordNerd10000, .wordNerd20000, .wordNerd50000:
            "shield.fill"
        case .streakFreak2, .streakFreak7, .streakFreak14, .streakFreak31, .streakFreak100:
            "eyeglasses"
        case .quickWords250, .quickWords500, .quickWords1000, .quickWords2000, .quickWords5000:
            "pencil.and.scribble"
        case .bookGoal:
            "target"
        }
    }
    
    func getText() -> String {
        switch self {
        case .twentySprint:
            "20 minute sprint"
        case .fortySprint:
            "40 minute sprint"
        case .hourSprint:
            "1 hour sprint"
        case .wordNerd200:
            "Write 200 words in the app"
        case .wordNerd500:
            "Write 500 words in the app"
        case .wordNerd1000:
            "Write 1000 words in the app"
        case .wordNerd10000:
            "Write 10, 000 words in the app"
        case .wordNerd20000:
            "Write 20, 000 words in the app"
        case .wordNerd50000:
            "Write 50, 000 words in the app"
        case .streakFreak2:
            "Get a 2 day streak"
        case .streakFreak7:
            "Get a 7 day streak"
        case .streakFreak14:
            "Get a 14 day streak"
        case .streakFreak31:
            "Get a 31 day streak"
        case .streakFreak100:
            "Get a 100 day streak"
        case .quickWords250:
            "Write 250 words in a sprint"
        case .quickWords500:
            "Write 500 words in a sprint"
        case .quickWords1000:
            "Write 1000 words in a sprint"
        case .quickWords2000:
            "Write 2000 words in a sprint"
        case .quickWords5000:
            "Write 5000 words in a sprint"
        case .bookGoal:
            "Hit your book's target word count"
        }
    }
}
