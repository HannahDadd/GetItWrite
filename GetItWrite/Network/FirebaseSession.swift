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

	func logIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
		Auth.auth().signIn(withEmail: email, password: password, completion: handler)
	}

	func logOut() {
		try! Auth.auth().signOut()
		self.user = nil
	}
    
    func deleteAccount(handler: @escaping UserProfileChangeCallback) {
        
        Auth.auth().currentUser?.delete(completion: handler)
    }
    
    func resetPassword(email: String, handler: @escaping SendPasswordResetCallback) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: handler)
        guard let userData = self.userData else { return }
        Firestore.firestore().collection("users").document(userData.id).delete()
    }

	func reauthenticate(email: String, password: String, handler: @escaping AuthDataResultCallback) {
		let user = Auth.auth().currentUser
		let credential = EmailAuthProvider.credential(withEmail: email, password: password)

		user?.reauthenticate(with: credential, completion: handler)
	}

	func changePassword(password: String, handler: @escaping SendPasswordResetCallback) {
		Auth.auth().currentUser?.updatePassword(to: password, completion: handler)
	}

	func changeEmail(email: String, handler: @escaping UserUpdateCallback) {
		Auth.auth().currentUser?.updateEmail(to: email, completion: handler)
	}

	func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
		Auth.auth().createUser(withEmail: email, password: password, completion: handler)
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
