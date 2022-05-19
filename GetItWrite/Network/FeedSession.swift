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
				completion(.success(requestCritiques ?? []))
			}
		}
	}

	func newProject(title: String, blurb: String, genres: [String], triggerWarnings: [String]) {
		guard let userData = self.userData else { return }

		Firestore.firestore().collection("projects")
			.document().setData(["title": title,
								 "blurb": blurb,
								 "genres": genres,
								 "timestamp": FieldValue.serverTimestamp(),
								 "writerId": userData.id,
								 "writerName": userData.displayName,
								 "triggerWarnings": triggerWarnings]) { (err) in
				if err != nil { print(err.debugDescription) }
			}
	}

	func newCritiqueRequest(title: String, text: String, blurb: String, genres: [String], triggerWarnings: [String]) {
		guard let userData = self.userData else { return }

		Firestore.firestore().collection("projects")
			.document().setData(["title": title,
								 "text": text.replacingOccurrences(of: "\\n{2,}", with: "\n", options: .regularExpression),
								 "blurb": blurb,
								 "genres": genres,
								 "timestamp": FieldValue.serverTimestamp(),
								 "writerId": userData.id,
								 "writerName": userData.displayName,
								 "critiques": [],
								 "triggerWarnings": triggerWarnings]) { (err) in
				if err != nil { print(err.debugDescription) }
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

	func submitCritique(requestCritique: RequestCritique, comments: [Int: String], overallFeedback: String) {
//		guard let userData = self.userData else { return }
//		project.critiques.append(userData.id)
//
//		Firestore.firestore().collection("projects").document(project.id).collection("critiques")
//			.document().setData(["comments": Dictionary(uniqueKeysWithValues: comments.map({ ($1, $0) })),
//								 "overallFeedback": overallFeedback,
//								 "timestamp": FieldValue.serverTimestamp(),
//								 "critiquerProfieColour": userData.colour,
//								 "critiquerId": userData.id,
//								 "critiquerName": userData.displayName,
//								 "rated": false]) { (err) in }
//
//		Firestore.firestore().collection("projects").document(project.id)
//			.updateData(["critiques": project.critiques]) { (err) in }
	}

	func submitRating(userId: String, rating: Int, projectId: String, critiqueId: String) {

		Firestore.firestore().collection("users").document(userId).getDocument { (document, error) in
			if let document = document, let user = User(dictionary: document.data() ?? [:], id: document.documentID) {
				let newRating = user.rating + rating
				Firestore.firestore().collection("users").document(userId)
					.updateData(["rating": newRating]) { (err) in }
			}
		}

		Firestore.firestore().collection("projects").document(projectId).collection("critiques")
			.document(critiqueId).updateData(["rated": true]) { (err) in }
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

		Firestore.firestore().collection("proposals").order(by: "timestamp", descending: false).getDocuments { (querySnapshot, error) in
			if let error = error {
				completion(.failure(error))
			} else {
				let projects = querySnapshot?.documents.map { Proposal(dictionary: $0.data(), id: $0.documentID) }.compactMap ({ $0 })
				completion(.success(projects ?? []))
			}
		}
	}

	func newProposal(project: Project, wordCount: Int, authorNotes: String, typeOfProject: String) {
		guard let userData = self.userData else { return }

		Firestore.firestore().collection("proposals")
			.document().setData(["title": project.title,
								 "typeOfProject": typeOfProject,
								 "timestamp": FieldValue.serverTimestamp(),
								 "blurb": project.blurb,
								 "genres": project.genres,
								 "triggerWarnings": project.triggerWarnings,
								 "wordCount": wordCount,
								 "writerId": userData.id,
								 "writerName": userData.displayName,
								 "authorNotes": authorNotes]) { (err) in
				if err != nil { return }
			}
	}
}
