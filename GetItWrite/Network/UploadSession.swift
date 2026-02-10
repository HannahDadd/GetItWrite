//
//  SprintsNetworking.swift
//  Get It Write
//
//  Created by Hannah Dadd on 13/01/2026.
//

import Firebase
import FirebaseFirestore

final class UploadSession {
    
    func startSprint(username: String, completion: @escaping (Error?) -> Void) {
        let date = Calendar.current.date(byAdding: .minute, value: 10, to: Date.now) ?? Date()
        let s = Sprint(id: UUID().uuidString, timestamp: Timestamp(date: date), participants: [username])
        
        Firestore.firestore().collection(DatabaseNames.sprint.rawValue).document(s.id).setData(s.dictionary as [String : Any]) { (err) in
                completion(err)
            }
    }
}
