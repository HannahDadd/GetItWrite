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

	func getUserFromId(id: String, completion: @escaping (Result<User, Error>) -> Void) {
		Firestore.firestore().collection("users").document(id).getDocument { (document, error) in
			if let error = error {
				completion(.failure(error))
			} else if let document = document, document.exists, let data = document.data(), let user = User(dictionary: data, id: document.documentID) {
				completion(.success(user))
			} else {
				completion(.failure(CustomError(title: "Failed to load user", description: "Failed to load user", code: 342)))
			}
		}
	}

	func logIn(email: String, password: String, handler: ((AuthDataResult?, (any Error)?) -> Void)?) {
		Auth.auth().signIn(withEmail: email, password: password, completion: handler)
	}

	func logOut(handler: (((any Error)?) -> Void)?) {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.userData = nil
        } catch {
            
        }
	}
    
    func deleteAccount(handler: (((any Error)?) -> Void)?) {
        guard let userData = self.userData else { return }
        Auth.auth().currentUser?.delete(completion: handler)
        Firestore.firestore().collection("users").document(userData.id).delete()
        self.user = nil
        self.userData = nil
    }
    
    func resetPassword(email: String, handler: (((any Error)?) -> Void)?) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: handler)
    }

	func reauthenticate(email: String, password: String, handler: ((AuthDataResult?, (any Error)?) -> Void)?) {
		let user = Auth.auth().currentUser
		let credential = EmailAuthProvider.credential(withEmail: email, password: password)

		user?.reauthenticate(with: credential, completion: handler)
	}

	func changePassword(password: String, handler: (((any Error)?) -> Void)?) {
		Auth.auth().currentUser?.updatePassword(to: password, completion: handler)
	}

	func changeEmail(email: String, handler: (((any Error)?) -> Void)?) {
		Auth.auth().currentUser?.updateEmail(to: email, completion: handler)
	}

	func signUp(email: String, password: String, handler: ((AuthDataResult?, (any Error)?) -> Void)?) {
		Auth.auth().createUser(withEmail: email, password: password, completion: handler)
	}
    
    func updateUser(bio: String? = nil, writing: String? = nil, authors: [String]? = nil, writingGenres: [String]? = nil, critiqueStyle: String? = nil, blockedUserIds: [String]? = nil, lastCritique: Timestamp? = nil, lastFiveCritiques: [Timestamp]? = nil, frequencey: Double? = nil, critiquerExpected: String? = nil) {
        guard let id = user?.uid else { return }
        guard var userData = self.userData else { return }
        
        userData.bio = bio ?? userData.bio
        userData.writing = writing ?? userData.writing
        userData.authors = authors ?? userData.authors
        userData.writingGenres = writingGenres ?? userData.writingGenres
        userData.critiqueStyle = critiqueStyle ?? userData.critiqueStyle
        userData.blockedUserIds = blockedUserIds ?? userData.blockedUserIds
        userData.lastCritique = lastCritique ?? userData.lastCritique
        userData.lastFiveCritiques = lastFiveCritiques ?? userData.lastFiveCritiques
        userData.frequencey = frequencey ?? userData.frequencey
        userData.critiquerExpected = critiquerExpected ?? userData.critiquerExpected

        Firestore.firestore().collection("users").document(id).setData(userData.dictionary as [String : Any]) { (err) in }
        self.userData = userData
    }

	func updateUser(newUser: User) {
		guard let id = user?.uid else { return }

		Firestore.firestore().collection("users").document(id).setData(newUser.dictionary as [String : Any]) { (err) in }
		self.userData = newUser
	}

	//    func uploadProfiePic(uiImage: UIImage?) {
	//        guard let image: UIImage = uiImage else { return }
	//        guard let id = user?.uid else { return }
	//
	//        let storageRef = Storage.storage().reference().child(id + ".png")
	//        if let uploadData = image.pngData() {
	//            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
	//                if error != nil { print(error.debugDescription) }
	//                storageRef.downloadURL { (url, error) in
	//                    self.session?.userData?.photoURL = url
	//                    Firestore.firestore().collection("users").document(id).updateData(["photoUrl": url?.absoluteString ?? ""]) { (err) in }
	//                }
	//            }
	//        }
	//    }
}
