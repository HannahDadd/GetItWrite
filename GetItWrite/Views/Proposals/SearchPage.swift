//
//  SearchPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 02/09/2024.
//

import SwiftUI

struct SearchPage: View {
    @EnvironmentObject var session: FirebaseSession

    var body: some View {
        ScrollView {
            VStack {
                NavigationLink(destination: ProposalsFeed(genre: "All").environmentObject(session)) {
                    LongArrowButton(title: "View all", action: {})
                }.padding()
                FilterByAudience()
                FilterByGenre()
            }
        }
    }
}

struct FilterByGenre: View {
    @EnvironmentObject var session: FirebaseSession
    
    let genres = [
        GenreAndImage(imageName: "scifi", title: "Sci Fi", dbName: "Science Fiction"),
        GenreAndImage(imageName: "crime", title: "Mystery", dbName: "Mystery"),
        GenreAndImage(imageName: "dystopian", title: "Dystopian", dbName: "Dystopian"),
        GenreAndImage(imageName: "fantasy", title: "Fantasy", dbName: "Fantasy"),
        GenreAndImage(imageName: "histroical", title: "Historical", dbName: "Historical"),
        GenreAndImage(imageName: "magicalrealism", title: "Magical Realism", dbName: "Magical Realism"),
        GenreAndImage(imageName: "memoir", title: "Memoir", dbName: "Memoir"),
        GenreAndImage(imageName: "romance", title: "Romance", dbName: "Romance"),
        GenreAndImage(imageName: "thriller", title: "Thriller", dbName: "Thriller"),
        GenreAndImage(imageName: "shortstory", title: "Short Stories", dbName: "Short Stories")
    ]

    var body: some View {
        VStack(alignment: .leading) {
            TitleAndSubtitle(title: "Filter by genre", subtitle: "Find critique partners writing for the same genre as you.")
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 16) {
                ForEach(genres) { g in
                    NavigationLink(destination: ProposalsFeed(genre: g.dbName).environmentObject(session)) {
                        HStack {
                            Image(g.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 75, height: 75)
                            Text(g.title)
                            Spacer()
                        }
                        .frame(minWidth: 120, maxWidth: .infinity, minHeight: 75)
                        .foregroundColor(Color.onCardBackground)
                        .background(Color.cardBackground)
                        .cornerRadius(8)
                        .shadow(radius: 5)
                    }
                }
            }.padding()
        }
    }
}

struct FilterByAudience: View {
    @EnvironmentObject var session: FirebaseSession
    
    let genres = [
        GenreAndImage(imageName: "adults", title: "Adult", dbName: "Adult"),
        GenreAndImage(imageName: "ya", title: "YA", dbName: "Young Adult"),
        GenreAndImage(imageName: "childrens", title: "Childrens", dbName: "Middle Grade")
    ]

    var body: some View {
        VStack(alignment: .leading) {
            TitleAndSubtitle(title: "Filter by target audience", subtitle: "Find critique partners writing for the same target audience as you.")
            HStack {
                ForEach(genres) { g in
                    NavigationLink(destination: ProposalsFeed(genre: g.dbName).environmentObject(session)) {
                        Image(g.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay {
                                VStack {
                                    Spacer()
                                    Text(g.title)
                                        .background(.white)
                                        .foregroundColor(.black)
                                }
                            }
                    }
                }
            }.padding()
        }
    }
}

struct GenreAndImage: Hashable, Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let dbName: String
}
