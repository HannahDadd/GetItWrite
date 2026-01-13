//
//  SprintsNetworking.swift
//  Get It Write
//
//  Created by Hannah Dadd on 13/01/2026.
//

import Firebase
import FirebaseFirestore
import Combine

class SprintsNetworking: ObservableObject {
    
    func pollSprint(completion: @escaping (Result<[RequestCritique], Error>) -> Void) {

        Firestore.firestore().collection("sprints").order(by: "timestamp", descending: true).limit(to: 1).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let projects = querySnapshot?.documents.map { RequestCritique(dictionary: $0.data(), id: $0.documentID) }.compactMap ({ $0 })
                completion(.success(projects ?? []))
            }
        }
    }
}
