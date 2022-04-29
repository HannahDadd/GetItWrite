//
//  Feed.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 20/02/2022.
//

import Firebase

extension FirebaseSession {

	func loadPosts(completion: @escaping (Result<[Project], Error>) -> Void) {

		if hasLoadedFeed { return }

		Firestore.firestore().collection("projects").order(by: "timestamp", descending: false)
			.addSnapshotListener { (snap, err) in
				if let error = err {
					completion(.failure(error))
				} else {
					self.hasLoadedFeed = true
					completion(.success(snap?.documents.map { Project(dictionary: $0.data(), id: $0.documentID) }.compactMap { $0 } ?? []))
				}
			}
	}

	func newWork(title: String, text: String, synopsisSoFar: String, typeOfProject: String, blurb: String, genres: [String], triggerWarnings: [String]) {
		guard let userData = self.userData else { return }

		Firestore.firestore().collection("projects")
			.document().setData(["title": title,
								 "text": text,
								 "synopsisSoFar": synopsisSoFar,
								 "typeOfProject": typeOfProject,
								 "blurb": blurb,
								 "genres": genres,
								 "timestamp": FieldValue.serverTimestamp(),
								 "writerId": userData.id,
								 "writerName": userData.displayName ?? "",
								 "critiques": 0,
								 "triggerWarnings": triggerWarnings]) { (err) in
				if err != nil { print(err.debugDescription) }
			}
	}

	func loadUserProjects(completion: @escaping (Result<[Project], Error>) -> Void) {
		guard let userData = self.userData else { return }

		Firestore.firestore().collection("projects").whereField("posterId", isEqualTo: userData.id).getDocuments { (querySnapshot, error) in
			if let error = error {
				completion(.failure(error))
			} else {
				let projects = querySnapshot?.documents.map { Project(dictionary: $0.data(), id: $0.documentID) }.compactMap ({ $0 })
				completion(.success(projects ?? []))
			}
		}
	}

	func submitCritique(project: Project, comments: [Int: String], overallFeedback: String) {
		guard let userData = self.userData else { return }
		project.critiques.append(userData.id)

		Firestore.firestore().collection("projects").document(project.id).collection("critiques")
			.document().setData(["comments": Dictionary(uniqueKeysWithValues: comments.map({ ($1, $0) })),
								 "overallFeedback": overallFeedback,
								 "timestamp": FieldValue.serverTimestamp(),
								 "posterImage": userData.photoURL?.absoluteString ?? "",
								 "posterId": userData.id,
								 "posterUsername": userData.displayName ?? ""]) { (err) in }

		Firestore.firestore().collection("projects").document(project.id)
			.setData(["critiques": project.critiques]) { (err) in }
	}

	func loadCritiques(id: String, completion: @escaping (Result<[Critique], Error>) -> Void) {

		Firestore.firestore().collection("projects").document(id).collection("critiques").getDocuments { (querySnapshot, error) in
			if let error = error {
				completion(.failure(error))
			} else {
				let projects = querySnapshot?.documents.map { Critique(dictionary: $0.data(), id: $0.documentID) }.compactMap ({ $0 })
				completion(.success(projects ?? []))
			}
		}
	}
}
