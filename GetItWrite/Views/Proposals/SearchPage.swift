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
        VStack {
            NavigationLink(destination: ProposalsFeed(genre: "All").environmentObject(session)) {
                LongArrowButton(title: "View all", action: {})
            }
            FilterByAudience()
            FilterByGenre()
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
        VStack {
            TitleAndSubtitle(title: "", subtitle: "")
            Grid {
                ForEach(genres) { g in
                    NavigationLink(destination: ProposalsFeed(genre: g.dbName).environmentObject(session)) {
                        HStack {
                            Image(g.imageName)
                            Text(g.title)
                        }
                        .foregroundColor(Color.onCardBackground)
                        .background(Color.cardBackground)
                        .frame(height: 100)
                    }
                }
            }
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
        VStack {
            TitleAndSubtitle(title: "", subtitle: "")
            Grid {
                ForEach(genres) { g in
                    NavigationLink(destination: ProposalsFeed(genre: g.dbName).environmentObject(session)) {
                        ZStack {
                            Image(g.imageName)
                            VStack {
                                Spacer()
                                Text(g.title)
                                    .background(.white)
                                    .foregroundColor(.black)
                            }
                        }
                        .background(Color.cardBackground)
                        .frame(height: 150)
                    }
                }
            }
        }
    }
}

struct GenreAndImage: Hashable, Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let dbName: String
}
