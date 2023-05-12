//
//  Feed.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 20/02/2022.
//

import Firebase

extension FirebaseSession {

	func loadRequestCritiques(completion: @escaping (Result<[RequestCritique], Error>) -> Void) {
		guard let userData = self.userData else { return }

		Firestore.firestore().collection("users").document(userData.id).collection("requestCritiques").order(by: "timestamp", descending: false).getDocuments { (querySnapshot, error) in
			if let error = error {
				completion(.failure(error))
			} else {
				let requestCritiques = querySnapshot?.documents.map { RequestCritique(dictionary: $0.data(), id: $0.documentID) }.compactMap ({ $0 })
                self.requestedCritiques = requestCritiques
				completion(.success(requestCritiques ?? []))
			}
		}
	}

	func loadUserProjects(completion: @escaping (Result<[Project], Error>) -> Void) {
		guard let userData = self.userData else { return }

		Firestore.firestore().collection("projects").whereField("writerId", isEqualTo: userData.id).getDocuments { (querySnapshot, error) in
			if let error = error {
				completion(.failure(error))
			} else {
				let projects = querySnapshot?.documents.map { Project(dictionary: $0.data(), id: $0.documentID) }.compactMap ({ $0 })
				completion(.success(projects ?? []))
			}
		}
	}

	func loadCritiques(completion: @escaping (Result<[Critique], Error>) -> Void) {
		guard let userData = self.userData else { return }

		Firestore.firestore().collection("users").document(userData.id).collection("critiques").order(by: "timestamp", descending: false).getDocuments { (querySnapshot, error) in
			if let error = error {
				completion(.failure(error))
			} else {
				let projects = querySnapshot?.documents.map { Critique(dictionary: $0.data(), id: $0.documentID) }.compactMap ({ $0 })
				completion(.success(projects ?? []))
			}
		}
	}

	func loadProposals(completion: @escaping (Result<[Proposal], Error>) -> Void) {

		Firestore.firestore().collection("proposals").order(by: "timestamp", descending: true).getDocuments { (querySnapshot, error) in
			if let error = error {
				completion(.failure(error))
			} else {
				let projects = querySnapshot?.documents.map { Proposal(dictionary: $0.data(), id: $0.documentID) }.compactMap ({ $0 })
				completion(.success(projects ?? []))
			}
		}
	}
}
