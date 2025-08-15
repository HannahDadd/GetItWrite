//
//  LatestBookCard.swift
//  Get It Write
//
//  Created by Hannah Dadd on 28/01/2025.
//

import SwiftUI

struct BookCard: View {
    let proposal: Proposal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(proposal.title)
                .font(Font.custom("AbrilFatface-Regular", size: 32))
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            Text("\(proposal.wordCount) words")
                .foregroundColor(Color.subtitleGenre)
                .multilineTextAlignment(.leading)
                .font(.caption)
                .lineLimit(2)
            Spacer()
            TagCloud(tags: proposal.genres, chosenTags: .constant([]), singleTagView: false, isTransparent: true)
        }
        .padding()
        .frame(width: 230, height: 300)
        .background(Genres.colour(genre: proposal.genres.last))
        .cornerRadius(8)
    }
}

enum Genres: String {
    case ya = "Young Adult"
    case adult = "Adult"
    case mg = "Middle Grade"
    case fantasy = "Fantasy"
    case magicalRealism = "Magical Realism"
    case histroical = "Histroical"
    case romance = "Romance"
    case scifi = "Science Fiction"
    case memoir = "Memoir"
    case womensFiction = "Women's Fiction"
    case shortstories = "Short Stories"
    case dystopian = "Dystopian"
    case mystery = "Mystery"
    case thriller = "Thriller"
    
    static func colour(genre: String?) -> Color {
        if let genre = genre {
            switch genre {
            case "Fantasy":
                return Color.init("Fantasy")
            case "Magical Realism":
                return Color.init("Magical Realism")
            case "Histroical":
                return Color.init("Histroical")
            case "Romance":
                return Color.init("Romance")
            case "Science Fiction":
                return Color.init("Science Fiction")
            case "Memoir":
                return Color.init("Memoir")
            case "Women's Fiction":
                return Color.init("Women's Fiction")
            case "Short Stories":
                return Color.init("Short Stories")
            case "Dystopian":
                return Color.init("Dystopian")
            case "Mystery":
                return Color.init("Mystery")
            case "Thriller":
                return Color.init("Thriller")
            default:
                return Color.init("Default")
            }
        } else {
            return Color.init("Default")
        }
    }
}
