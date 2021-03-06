//
//  FirebaseUser.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/02/2022.
//

import Foundation
import UIKit

class FirebaseUser: Equatable, Hashable {

    let uid: String
    let email: String?

    static func == (lhs: FirebaseUser, rhs: FirebaseUser) -> Bool {
        lhs.uid == rhs.uid
    }

	func hash(into hasher: inout Hasher) {
		hasher.combine(uid)
	}

    init(uid: String, email: String?) {
        self.uid = uid
        self.email = email
    }
}
