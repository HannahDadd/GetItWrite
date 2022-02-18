//
//  FirebaseSession.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/02/2022.
//

import Firebase
import FirebaseFirestore

class FirebaseSession: ObservableObject {

    //MARK: Properties
    @Published var session: FirebaseUser?
    @Published var isLoggedIn: Bool?
}
