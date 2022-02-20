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

        Firestore.firestore().collection("Works").order(by: "timestamp", descending: false).addSnapshotListener { (snap, err) in
            if let error = err {
                completion(.failure(error))
            } else {
                self.hasLoadedFeed = true
                let posts = snap?.documents.map { Work(dictionary: $0.data(), id: $0.documentID) }.compactMap ({ $0 })
                completion(.success(posts ?? []))
            }
        }
    }

//    func post(text : String, interest: String, imageUrl: URL?) {
//        guard let id = session?.uid else { return }
//
//        Firestore.firestore().collection("posts").document().setData(["text": text, "image": imageUrl?.absoluteString ?? "", "likes": [], "comments": [], "interest": interest, "timestamp": FieldValue.serverTimestamp(), "posterImage": self.session?.userData?.photoURL ?? "", "posterId": id, "posterUsername": self.session?.userData?.displayName ?? ""]) { (err) in
//            if err != nil { print(err.debugDescription) }
//        }
//    }
}
