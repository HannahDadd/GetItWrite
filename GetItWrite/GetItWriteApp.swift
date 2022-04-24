//
//  GetItWriteApp.swift
//  GetItWrite
//
//  Created by Hannah Dadd on 23/01/2022.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct GetItWriteApp: App {
    init() {
//        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
			GiveCritiqueView(work: Work(id: "", title: "Catching Killers and Other A Levels I didn't Take", text: "Heya this is the work I've written. WHo doesn't love to write. Woohoo. Lots of words.", synopsisSoFar: "What a fantastic stoy this is", typeOfWork: "Query", blurb: "Woohoo story", genres: ["Young Adult", "Fantasy"], timestamp: Timestamp(), posterImage: "", posterId: "", posterUsername: ""))
        }
    }
}
