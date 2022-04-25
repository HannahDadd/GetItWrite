//
//  FirebaseSession.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/02/2022.
//

import Firebase
import FirebaseFirestore
import Combine

class FirebaseSession: ObservableObject {

    //MARK: Properties
    @Published var user: FirebaseUser?
    @Published var userData: User?
    var hasLoadedFeed = false

    func listen(completion: @escaping (Result<User, Error>) -> Void) {
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.user = FirebaseUser(uid: user.uid, email: user.email)
                Firestore.firestore().collection("users").document(user.uid).getDocument { (document, error) in
                    if let error = error {
                        completion(.failure(error))
                    } else if let document = document, document.exists, let data = document.data(), let user = User(dictionary: data, id: document.documentID) {
						self.userData = user
                        completion(.success(user))
                    } else {
                        completion(.failure(CustomError(title: "Failed to decode user", description: "Failed to decode user", code: 342)))
                    }
                }
            } else {
                self.user = nil
                completion(.failure(CustomError(title: "Not logged in", description: "Not logged in", code: 342)))
            }
        }
    }
}
