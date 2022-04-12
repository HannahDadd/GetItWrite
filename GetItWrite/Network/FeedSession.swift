//
//  Feed.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 20/02/2022.
//

import Firebase

extension FirebaseSession {

    func loadPosts(completion: @escaping (Result<[Work], Error>) -> Void) {

        if hasLoadedFeed { return }

        Firestore.firestore().collection("works").order(by: "timestamp", descending: false).addSnapshotListener { (snap, err) in
            if let error = err {
                completion(.failure(error))
            } else {
                self.hasLoadedFeed = true
                let posts = snap?.documents.map { Work(dictionary: $0.data(), id: $0.documentID) }.compactMap ({ $0 })
                completion(.success(posts ?? []))
            }
        }
    }

	func post(title: String, text: String, synopsisSoFar: String, typeOfWork: String, blurb: String, genres: [String]) {
		guard let userData = self.userData else { return }

		Firestore.firestore().collection("works").document().setData(["title": title, "text": text, "synopsisSoFar": synopsisSoFar, "typeOfWork": typeOfWork, "blurb": blurb, "genres": genres, "timestamp": FieldValue.serverTimestamp(), "posterImage": userData.photoURL?.absoluteString ?? "", "posterId": userData.id, "posterUsername": userData.displayName ?? ""]) { (err) in
            if err != nil { print(err.debugDescription) }
        }
    }
}
