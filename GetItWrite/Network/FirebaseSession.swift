//
//  FirebaseSession.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/02/2022.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import GeoFire

class FirebaseSession: ObservableObject {

    //MARK: Properties
    @Published var session: FirebaseUser?
    @Published var isLoggedIn: Bool?
    @Published var instagramUser: InstagramUser?
    @Published var testUserData: InstagramTestUser?

    @ObservedObject public var imageLoader: ImageLoader = ImageLoader()

    var hasLoadedFeed = false

    typealias CompletionHandler = (_ success:Bool) -> Void
}
