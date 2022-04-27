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

        Firestore.firestore().collection("works").order(by: "timestamp", descending: false)
			.addSnapshotListener { (snap, err) in
            if let error = err {
                completion(.failure(error))
            } else {
                self.hasLoadedFeed = true
                completion(.success(snap?.documents.map { Work(dictionary: $0.data(), id: $0.documentID) }.compactMap { $0 } ?? []))
            }
        }
    }

	func post(title: String, text: String, synopsisSoFar: String, typeOfWork: String, blurb: String, genres: [String]) {
		guard let userData = self.userData else { return }

		Firestore.firestore().collection("works").document().setData(["title": title, "text": text, "synopsisSoFar": synopsisSoFar, "typeOfWork": typeOfWork, "blurb": blurb, "genres": genres, "timestamp": FieldValue.serverTimestamp(), "posterImage": userData.photoURL?.absoluteString ?? "", "posterId": userData.id, "posterUsername": userData.displayName ?? "", "critiques": []]) { (err) in
            if err != nil { print(err.debugDescription) }
        }
    }

	func loadUserWorks(completion: @escaping (Result<[Work], Error>) -> Void) {
		guard let userData = self.userData else { return }

		Firestore.firestore().collection("works").whereField("posterId", isEqualTo: userData.id).getDocuments { (querySnapshot, error) in
			if let error = error {
				completion(.failure(error))
			} else if let documents = querySnapshot?.documents {
				completion(.success(documents.map { Work(dictionary: $0.data(), id: $0.documentID)! }))
			} else {
				completion(.failure(CustomError(title: "Failed to load works", description: "Failed to load your works- we'll fix this asap.", code: 342)))
			}
		}
 }
}
