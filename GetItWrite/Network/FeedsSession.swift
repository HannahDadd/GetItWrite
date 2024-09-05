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

		Firestore.firestore().collection(DatabaseNames.users.rawValue).document(userData.id).collection(DatabaseNames.requestCritiques.rawValue).order(by: "timestamp", descending: false).limit(to: 25).getDocuments { (querySnapshot, error) in
			if let error = error {
				completion(.failure(error))
			} else {
				let requestCritiques = querySnapshot?.documents.map { RequestCritique(dictionary: $0.data(), id: $0.documentID) }.compactMap ({ $0 })
				completion(.success(requestCritiques ?? []))
			}
		}
	}

	func loadUserProposals(completion: @escaping (Result<[Proposal], Error>) -> Void) {
		guard let userData = self.userData else { return }

		Firestore.firestore().collection(DatabaseNames.proposals.rawValue).whereField("writerId", isEqualTo: userData.id).limit(to: 25).getDocuments { (querySnapshot, error) in
			if let error = error {
				completion(.failure(error))
			} else {
				let projects = querySnapshot?.documents.map { Proposal(dictionary: $0.data(), id: $0.documentID) }.compactMap ({ $0 })
				completion(.success(projects ?? []))
			}
		}
	}
    
    func loadCritiquedFrenzy(dbName: String, completion: @escaping (Result<[Critique], Error>) -> Void) {
        guard let userData = self.userData else { return }

        Firestore.firestore().collection(DatabaseNames.users.rawValue).document(userData.id).collection(dbName).order(by: "timestamp", descending: true).limit(to: 25).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let projects = querySnapshot?.documents.map { Critique(dictionary: $0.data(), id: $0.documentID) }.compactMap ({ $0 })
                completion(.success(projects ?? []))
            }
        }
    }
    
    func loadPositivities(completion: @escaping (Result<[RequestPositivity], Error>) -> Void) {
        guard let userData = self.userData else { return }

        Firestore.firestore().collection(DatabaseNames.users.rawValue).document(userData.id).collection(DatabaseNames.positivityPeices.rawValue).order(by: "timestamp", descending: true).limit(to: 25).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let projects = querySnapshot?.documents.map { RequestPositivity(dictionary: $0.data(), id: $0.documentID) }.compactMap ({ $0 })
                completion(.success(projects ?? []))
            }
        }
    }

	func loadCritiques(completion: @escaping (Result<[Critique], Error>) -> Void) {
		guard let userData = self.userData else { return }

		Firestore.firestore().collection(DatabaseNames.users.rawValue).document(userData.id).collection(DatabaseNames.critiques.rawValue).order(by: "timestamp", descending: true).limit(to: 25).getDocuments { (querySnapshot, error) in
			if let error = error {
				completion(.failure(error))
			} else {
				let projects = querySnapshot?.documents.map { Critique(dictionary: $0.data(), id: $0.documentID) }.compactMap ({ $0 })
				completion(.success(projects ?? []))
			}
		}
	}
    
    func loadPositivity(completion: @escaping (Result<RequestPositivity, Error>) -> Void) {
        guard let userData = self.userData else { return }

        Firestore.firestore()
            .collection(DatabaseNames.positivityPeices.rawValue)
            .document("ids").getDocument { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let idsArray = (querySnapshot?.data() as? [String]) ?? []
                Firestore.firestore()
                    .collection("positivityPeices")
                    .document(idsArray.randomElement() ?? "")
                    .getDocument { (querySnapshot, error) in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            if let data = querySnapshot?.data(),
                               let id = querySnapshot?.documentID {
                                if let p = RequestPositivity(dictionary: data, id: id) {
                                    completion(.success(p))
                                } else {
                                    completion(.failure(CustomError(title: "Failed to decode request positivity", description: "", code: 10)))
                                }
                            } else {
                                completion(.failure(CustomError(title: "Failed to decode request positivity", description: "", code: 10)))
                            }
                        }
                    }
            }
        }
    }
    
    func loadCritiqueFrenzy(dbName: String, completion: @escaping (Result<[RequestCritique], Error>) -> Void) {

        Firestore.firestore().collection(dbName).order(by: "timestamp", descending: false).limit(to: 25).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let projects = querySnapshot?.documents.map { RequestCritique(dictionary: $0.data(), id: $0.documentID) }.compactMap ({ $0 })
                completion(.success(projects ?? []))
            }
        }
    }
    
    func loadQuestions(completion: @escaping (Result<[Question], Error>) -> Void) {

        Firestore.firestore().collection(DatabaseNames.questions.rawValue).order(by: "timestamp", descending: true).limit(to: 25).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let projects = querySnapshot?.documents.map { Question(dictionary: $0.data(), id: $0.documentID) }.compactMap ({ $0 })
                completion(.success(projects ?? []))
            }
        }
    }
    
    func loadReplies(questionID: String, completion: @escaping (Result<[Reply], Error>) -> Void) {
        Firestore.firestore().collection(DatabaseNames.questions.rawValue).document(questionID).collection(DatabaseNames.replies.rawValue).order(by: "timestamp", descending: false).limit(to: 25).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let projects = querySnapshot?.documents.map { Reply(dictionary: $0.data()) }.compactMap ({ $0 })
                completion(.success(projects ?? []))
            }
        }
    }
    
    func listenToReplies(questionID: String, completion: @escaping (Result<[Reply], Error>) -> Void) {
        Firestore.firestore().collection(DatabaseNames.questions.rawValue).document(questionID).collection(DatabaseNames.replies.rawValue)
            .order(by: "timestamp", descending: false).addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let results = querySnapshot?.documents.map { Reply(dictionary: $0.data()) }.compactMap ({ $0 })
                completion(.success(results ?? []))
            }
        }
    }
    
    func loadProposals(genre: String, completion: @escaping (Result<[Proposal], Error>) -> Void) {

        Firestore.firestore().collection(DatabaseNames.proposals.rawValue)
            .whereField("genres", arrayContains: genre)
            .limit(to: 25).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let projects = querySnapshot?.documents.map { Proposal(dictionary: $0.data(), id: $0.documentID) }.compactMap ({ $0 })
                completion(.success(projects ?? []))
            }
        }
    }

	func loadProposals(completion: @escaping (Result<[Proposal], Error>) -> Void) {

		Firestore.firestore().collection(DatabaseNames.proposals.rawValue).order(by: "timestamp", descending: true).limit(to: 25).getDocuments { (querySnapshot, error) in
			if let error = error {
				completion(.failure(error))
			} else {
				let projects = querySnapshot?.documents.map { Proposal(dictionary: $0.data(), id: $0.documentID) }.compactMap ({ $0 })
				completion(.success(projects ?? []))
			}
		}
	}
    
    func getRecs(completion: @escaping (Result<[User], Error>) -> Void) {
        //.order(by: "lastCritique", descending: false)

        Firestore.firestore()
            .collection(DatabaseNames.users.rawValue)
            .limit(to: 10)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    let users = querySnapshot?.documents.map { u in
                        User(dictionary: u.data(), id: u.documentID)
                    }.compactMap { $0 }
                    if let users = users {
                        if let freq = self.userData?.frequencey {
                            
                            let recs = users
                                .filter { $0.frequencey != nil }
                                .sorted(by: { user1, user2 in
                                    abs(user1.frequencey! - freq) > abs(user2.frequencey! - freq)
                                })
                            if recs.count < 4 {
                                completion(.success(Array(users.prefix(3))))
                            } else {
                                completion(.success(Array(recs.prefix(3))))
                            }
                        }
                    } else {
                        completion(.success([]))
                    }
                }
        }
    }
}
