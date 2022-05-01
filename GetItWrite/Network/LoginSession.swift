//
//  Login.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/02/2022.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

extension FirebaseSession {

    func getUserFromId(id: String, completion: @escaping (Result<User, Error>) -> Void) {
        Firestore.firestore().collection("users").document(id).getDocument { (document, error) in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists, let data = document.data(), let user = User(dictionary: data, id: document.documentID) {
                completion(.success(user))
            } else {
                completion(.failure(CustomError(title: "Failed to decode user", description: "Failed to decode user", code: 342)))
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
